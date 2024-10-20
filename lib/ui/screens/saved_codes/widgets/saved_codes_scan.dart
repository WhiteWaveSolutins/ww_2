import 'package:flutter/material.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/buttons/button_with_icon.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';

class SavedCodesScan extends StatelessWidget {
  const SavedCodesScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.onboarding4,
          height: 322,
        ),
        const SizedBox(height: 24),
        GradientText.primary(
          'No saved codes',
          style: AppText.text16,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ButtonWithIcon(
            onPressed: getItService.navigatorService.onScan,
            title: 'Scan',
            icon: AppIcons.qrCode,
          ),
        ),
      ],
    );
  }
}
