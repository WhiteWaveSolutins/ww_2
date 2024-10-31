import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/data/services/shared_preferences_service.dart';
import 'package:ww_2/ui/screens/main/main_screen.dart';
import 'package:ww_2/ui/screens/onboarding/onboarding_screen.dart';
import 'package:ww_2/ui/state_manager/paywall/action.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/action.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Store<AppState> _store;

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<AppState>(context, listen: false);
    _store.dispatch(LoadSubscriptionAction());
    _store.dispatch(LoadPaywallListAction());
    _checkCount();
    _navigateToNext();
  }

  void _navigateToNext() async {
    final status = await SharedPreferencesService.getStatusShowOnboarding();
    if (!status) SharedPreferencesService.switchStatusShowOnboarding();
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => !status ? const MainScreen() : const OnboardingScreen(),
      ),
      (Route<dynamic> route) => false,
    );
    FlutterNativeSplash.remove();
  }

  void _checkCount() async {
    final date = await SharedPreferencesService.getDateUpdateCountGeneration();
    if (date != null) {
      final dif = DateTime.now().difference(date);
      if (dif >= const Duration(hours: 24)) {
        SharedPreferencesService.clearCountGeneration();
        SharedPreferencesService.clearDateUpdateCountGeneration();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
