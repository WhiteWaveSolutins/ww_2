import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/action.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingWidget extends StatelessWidget {
  final String buttonText;
  final Widget image;
  final String subtitle;
  final String? subtitleTapper;
  final Function()? tapperOnTap;
  final String title;
  final Function() onTapButton;

  const OnboardingWidget({
    super.key,
    this.buttonText = 'Next',
    required this.onTapButton,
    required this.title,
    this.subtitleTapper,
    required this.image,
    this.tapperOnTap,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: image,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GradientText.primary(
                title,
                style: AppText.h2,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 45,
                child: Column(
                  children: [
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: AppText.text2,
                    ),
                    if (subtitleTapper != null)
                      GestureDetector(
                        onTap: tapperOnTap,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          child: Text(
                            subtitleTapper!,
                            textAlign: TextAlign.center,
                            style: AppText.text2,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              BottomOnboarding(
                buttonText: buttonText,
                onTapButton: onTapButton,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BottomOnboarding extends StatelessWidget {
  final String buttonText;
  final Function() onTapButton;

  const BottomOnboarding({
    super.key,
    required this.onTapButton,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainButton(
          title: buttonText,
          onPressed: onTapButton,
        ),
        const SizedBox(height: 24),
        Opacity(
          opacity: .5,
          child: Text(
            'By clicking to the “Continue” button, you agree to our',
            style: AppText.text3,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => launchUrl(
                  Uri.parse(getItService.remoteConfigService.termsLink),
                  mode: LaunchMode.externalApplication,
                ),
                child: GradientText.primary(
                  'Terms of Use',
                  style: AppText.text3,
                ),
              ),
              GestureDetector(
                onTap: () => launchUrl(
                  Uri.parse(getItService.remoteConfigService.privacyLink),
                  mode: LaunchMode.externalApplication,
                ),
                child: GradientText.primary(
                  'Privacy Policy',
                  style: AppText.text3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final store = StoreProvider.of<AppState>(context, listen: false);
                  store.dispatch(RestoreSubscriptionAction(
                    onFinish: Navigator.of(context).pop,
                    onError: (e) {
                      showDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text("Some Error"),
                          content: Text(e),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              onPressed: Navigator.of(context).pop,
                              isDefaultAction: true,
                              child: const Text(
                                "Ok",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onLoad: () {
                      showDialog(
                        context: context,
                        builder: (_) => const Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ));
                },
                child: GradientText.primary(
                  'Restore',
                  style: AppText.text3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
