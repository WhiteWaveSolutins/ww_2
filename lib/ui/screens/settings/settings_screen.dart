import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gaimon/gaimon.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/services/email_service.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/state.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppText.h2.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: const LeftButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          StoreConnector<AppState, SubscriptionState>(
            converter: (store) => store.state.subscriptionState,
            builder: (context, state) {
              if (state.hasPremium) return const SizedBox();
              return Container(
                height: 130,
                padding: const EdgeInsets.only(right: 26),
                decoration: BoxDecoration(
                  color: const Color(0xFF272727),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.primary,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Image.asset(
                      AppImages.pict,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText.primary(
                              'Want more options?',
                              maxLines: 1,
                              style: AppText.text16.copyWith(
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const _ButtonSign(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          _Box(
            title: 'Feedback and support',
            buttons: [
              _Button(
                padding: 2,
                onTap: () async {
                  final inAppReview = InAppReview.instance;
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                },
                icon: AppIcons.star,
                title: 'Rate us',
              ),
              _Button(
                onTap: () {
                  EmailService.launchEmailSubmission(
                    toEmail: 'sertachindistan0617@outlook.com',
                    subject: "Contact with support",
                    body: "\"Your message here\"",
                  );
                },
                icon: AppIcons.support,
                title: 'Contact support',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _Box(
            title: 'About the program',
            buttons: [
              //_Button(
              //  icon: AppIcons.information,
              //  title: 'About us',
              //  onTap: () => launchUrl(
              //    Uri.parse(getItService.configService.aboutUsLink),
              //    mode: LaunchMode.inAppWebView,
              //  ),
              //),
              _Button(
                onTap: () => launchUrl(
                  Uri.parse(getItService.configService.termsLink),
                  mode: LaunchMode.inAppWebView,
                ),
                padding: 3,
                icon: AppIcons.pr,
                title: 'Terms of Use',
              ),
              _Button(
                onTap: () => launchUrl(
                  Uri.parse(getItService.configService.privacyLink),
                  mode: LaunchMode.inAppWebView,
                ),
                icon: AppIcons.doc,
                title: 'Privacy Policy',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String icon;
  final String title;
  final Function()? onTap;
  final double padding;

  const _Button({
    super.key,
    required this.title,
    required this.icon,
    this.padding = 6,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 1,
      onPressed: () {
        Gaimon.selection();
        onTap?.call();
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.yellowGrad1,
                    AppColors.yellowGrad2,
                  ],
                ),
              ),
              child: SvgIcon(
                icon: icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: AppText.text16,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final List<_Button> buttons;
  final String title;

  const _Box({
    super.key,
    required this.title,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.5,
          child: Text(
            title,
            style: AppText.text16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              for (int i = 0; i < buttons.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buttons[i],
                ),
                if (i != buttons.length - 1) Divider(color: AppColors.white.withOpacity(.1)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ButtonSign extends StatelessWidget {
  const _ButtonSign({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: getItService.navigatorService.onGetPremium,
      minSize: 1,
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                AppColors.yellowGrad1,
                AppColors.yellowGrad2,
              ],
            ),
          ),
          child: Center(
            child: Text(
              'Sign up for Premium',
              style: AppText.text3.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
