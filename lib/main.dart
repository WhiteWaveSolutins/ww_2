import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
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
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
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

  runApp(ScannerApp(locator: locator));
}

class ScannerApp extends StatelessWidget {
  final LocatorService locator;

  const ScannerApp({
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
          theme: lightThemeData,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}
