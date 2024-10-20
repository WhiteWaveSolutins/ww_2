import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/main.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/onboarding/widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: page == 0
            ? OnboardingWidget(
                image: Image.asset(AppImages.onboarding1),
                title: 'Qr & Barcodes scanner',
                subtitle: 'Scan QR codes or barcodes and save them to your history',
                onTapButton: () {
                  setState(() => page = 1);
                  InAppReview.instance.requestReview();
                },
              )
            : page == 1
                ? _Onboarding2(onTapButton: () => setState(() => page = 2))
                : page == 2
                    ? OnboardingWidget(
                        image: Image.asset(
                          AppImages.onboarding3,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        title: 'Generation of own Qr codes',
                        subtitle: 'Create your own Qr codes and customize them',
                        onTapButton: () {
                          if (offSubscribe) {
                            getItService.navigatorService.onMain();
                            return;
                          }
                          setState(() => page = 3);
                        },
                      )
                    : OnboardingWidget(
                        image: Image.asset(
                          AppImages.onboarding4,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        title: 'Get Premium',
                        subtitle: 'Start your 3-day free trial. Than 4.99\$ per week',
                        subtitleTapper: 'Or proceed with limited version',
                        buttonText: 'Try Free & Subscribe',
                        onTapButton: () {
                          getItService.navigatorService.onMain();
                          getItService.navigatorService.onGetPremium();
                        },
                      ),
      ),
    );
  }
}

class _Onboarding2 extends StatelessWidget {
  final Function() onTapButton;

  const _Onboarding2({
    super.key,
    required this.onTapButton,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      image: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppImages.onboarding2,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 40,
                ),
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  top: 38,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(
                  'The best application for scanning Qr codes. Clear interface, fast response. There is a function to create your own QR code. Thank you for such an app! 🚀📊',
                  style: AppText.text3.copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.black,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AppImages.faceOnboarding,
                  width: 70,
                  height: 70,
                ),
              ),
            ],
          ),
        ],
      ),
      title: 'We value your feedback',
      subtitle: 'They are the ones who inspire us to keep going',
      onTapButton: onTapButton,
    );
  }
}
