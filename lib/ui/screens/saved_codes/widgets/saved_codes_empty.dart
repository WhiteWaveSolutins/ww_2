import 'package:flutter/material.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';

class SavedCodesEmpty extends StatelessWidget {
  const SavedCodesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientText.primary(
          'Nothing found.\nTry spelling it differently',
          style: AppText.text16,
          textAlign: TextAlign.center,
        ),
        Image.asset(AppImages.onboarding1),
      ],
    );
  }
}
