// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/data/services/shared_preferences_service.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/main/main_screen.dart';
import 'package:ww_2/ui/screens/onboarding/onboarding_screen.dart';
import 'package:ww_2/ui/state_manager/paywall/action.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/action.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';

const TIMEOUT_SECONDS = 2;

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
    _navigateToNext();
  }

  void _navigateToNext() async {
    final status = await SharedPreferencesService.getStatusShowOnboarding();
    if (!status) SharedPreferencesService.switchStatusShowOnboarding();
    Future.delayed(
      const Duration(seconds: TIMEOUT_SECONDS),
      () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => status ? const MainScreen() : const OnboardingScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(animation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientText.primary(
              'Scan Pro',
              style: AppText.h1.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130),
              child: Image.asset(AppImages.logo),
            ),
          ],
        ),
      ),
    );
  }
}
