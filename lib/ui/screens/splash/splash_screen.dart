import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ww_2/data/services/shared_preferences_service.dart';
import 'package:ww_2/ui/screens/main/main_screen.dart';
import 'package:ww_2/ui/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    final status = await SharedPreferencesService.getStatusShowOnboarding();
    if (!status) SharedPreferencesService.switchStatusShowOnboarding();
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => status ? const MainScreen() : const OnboardingScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(
        color: Colors.white,
      ),
    );
  }
}
