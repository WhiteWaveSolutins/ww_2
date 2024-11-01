import 'package:flutter/material.dart';
import 'package:ww_2/ui/resurses/colors.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Gradient gradient;

  factory GradientText.primary(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      GradientText(
        text,
        style: style,
        gradient: const LinearGradient(
          colors: [
            AppColors.yellowGrad1,
            AppColors.yellowGrad2,
          ],
        ),
        textAlign: textAlign,
      );

  factory GradientText.black(
    String text, {
    TextStyle? style,
  }) =>
      GradientText(
        text,
        style: style,
        gradient: LinearGradient(
          colors: [
            AppColors.black,
            AppColors.black.withOpacity(.5),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
