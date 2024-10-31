import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:oktoast/oktoast.dart';
import 'package:ww_2/data/services/remote_config_service.dart';
import 'package:ww_2/domain/di/locator.dart';
import 'package:ww_2/route.dart';
import 'package:ww_2/ui/resurses/theme.dart';
import 'package:ww_2/ui/screens/splash/splash_screen.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:talker/talker.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  HttpOverrides.global = MyHttpOverrides();
  await ConfigService.instance.init();
  addLifecycleHandler();
  final locator = LocatorService();

  FlutterError.onError = (details) {
    Talker().logTyped(
      TalkerLog(
        details.exceptionAsString(),
        title: 'ERROR FLUTTER',
        logLevel: LogLevel.critical,
        stackTrace: details.stack,
      ),
    );
  };

  runApp(FApp(locator: locator));
}

class FApp extends StatelessWidget {
  final LocatorService locator;

  FApp({
    super.key,
    required this.locator,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return QrCodeScannerReaderScan(locator: locator);
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class QrCodeScannerReaderScan extends StatelessWidget {
  final LocatorService locator;

  const QrCodeScannerReaderScan({
    super.key,
    required this.locator,
  });

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: StoreProvider<AppState>(
        store: locator.store,
        child: MaterialApp(
          navigatorKey: locator.navigatorKey,
          home: const SplashScreen(),
          title: 'Qr code scanner - reader scan',
          theme: lightThemeData,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}

void addLifecycleHandler() {
  WidgetsBinding.instance.addObserver(
    AppLifecycleListener(
      onDetach: ConfigService.instance.closeClient,
    ),
  );
}
