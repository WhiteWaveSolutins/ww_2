import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/onboarding/widgets/onboarding_widget.dart';
import 'package:ww_2/ui/widgets/buttons/close_button.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';
import 'package:ww_2/ui/widgets/gradient_widget.dart';
import 'package:ww_2/ui/widgets/image_back.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class GetPremiumScreen extends StatelessWidget {
  const GetPremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageBack(
        image: AppImages.mainBack,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GradientText.primary(
                        'Get\nPremium',
                        style: AppText.text16.copyWith(
                          fontSize: 60,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const CloseButton2(),
                  ],
                ),
                const SizedBox(height: 8),
                Opacity(
                  opacity: .5,
                  child: Text(
                    'Get more features with\nPremium experience!',
                    style: AppText.text1.copyWith(
                      color: AppColors.white,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const _Prem(
                  title: 'Unlimited scanning',
                  icon: AppIcons.fireSmall,
                ),
                const SizedBox(height: 8),
                const _Prem(
                  title: 'No adds',
                  icon: AppIcons.noAdd,
                ),
                const SizedBox(height: 8),
                const _Prem(
                  title: 'Generating QR codes',
                  icon: AppIcons.crow,
                ),
                const SizedBox(height: 8),
                const _Prem(
                  title: 'Unlimited custom',
                  icon: AppIcons.gift,
                ),
                const SizedBox(height: 16),
                const _Price(),
                const Spacer(),
                BottomOnboarding(
                  buttonText: 'Try Free & Subscribe',
                  onTapButton: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Price extends StatelessWidget {
  const _Price({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
            color: AppColors.white.withOpacity(.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText.primary(
                '4,99\$ / weekly',
                style: AppText.text1,
              ),
              const SizedBox(height: 8),
              Opacity(
                opacity: .5,
                child: Text(
                  'Premium experience',
                  style: AppText.text16,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                AppColors.yellowGrad1,
                AppColors.yellowGrad2,
              ],
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SvgIcon(
                icon: AppIcons.starSolid,
                size: 19,
              ),
              const SizedBox(width: 8),
              Text(
                '3 Day Free',
                style: AppText.text3.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Prem extends StatelessWidget {
  final String title;
  final String icon;

  const _Prem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8,
        right: 16,
        left: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white.withOpacity(.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GradientWidget.primary(
            SvgIcon(
              icon: icon,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppText.text3,
          ),
        ],
      ),
    );
  }
}
