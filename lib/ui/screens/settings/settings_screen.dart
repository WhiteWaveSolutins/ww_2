import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ww_2/data/api/links.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/state.dart';
import 'package:ww_2/ui/widgets/buttons/close_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';
import 'package:ww_2/ui/widgets/gradient_widget.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: getItService.navigatorService.onPop,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 20,
                    sigmaY: 20,
                  ),
                  child: Container(
                    width: 54,
                    color: Colors.transparent,
                    height: double.infinity,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.black,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 32,
                    right: 32,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 18),
                      Text(
                        'Settings',
                        style: AppText.h2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SvgIcon(
                        icon: AppIcons.scanner,
                        size: 100,
                      ),
                      StoreConnector<AppState, SubscriptionState>(
                        converter: (store) => store.state.subscriptionState,
                        builder: (context, state) {
                          if (state.hasPremium) return const SizedBox();
                          return Column(
                            children: [
                              const SizedBox(height: 16),
                              GradientText.primary(
                                'Want more options?',
                                style: AppText.text1,
                              ),
                              const SizedBox(height: 16),
                              MainButton(
                                onPressed: getItService.navigatorService.onGetPremium,
                                title: 'Sign up for Premium',
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      //const _Button(
                      //  icon: AppIcons.playstation,
                      //  title: 'About us',
                      //),
                      //const _Button(
                      //  icon: AppIcons.version,
                      //  title: 'Version',
                      //),
                      _Button(
                        onTap: () async {
                          final inAppReview = InAppReview.instance;
                          if (await inAppReview.isAvailable()) {
                            inAppReview.requestReview();
                          }
                        },
                        icon: AppIcons.chat,
                        title: 'Rate us',
                      ),
                      _Button(
                        onTap: () => launchUrl(
                          Uri.parse(AppLinks.terms),
                          mode: LaunchMode.externalApplication,
                        ),
                        icon: AppIcons.document,
                        title: 'Terms of Use',
                      ),
                      _Button(
                        onTap: () => launchUrl(
                          Uri.parse(AppLinks.privacy),
                          mode: LaunchMode.externalApplication,
                        ),
                        icon: AppIcons.copy,
                        title: 'Privacy Policy',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 18,
              right: 16,
            ),
            child: const CloseButton2(),
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

  const _Button({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Row(
          children: [
            GradientWidget.primary(
              SvgIcon(
                icon: icon,
                size: 30,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: AppText.text16,
                textAlign: TextAlign.center,
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
