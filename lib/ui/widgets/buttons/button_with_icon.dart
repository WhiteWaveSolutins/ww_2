import 'package:flutter/cupertino.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class ButtonWithIcon extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onPressed;

  const ButtonWithIcon({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Opacity(
                opacity: 0,
                child: SvgIcon(
                  icon: icon,
                  size: 30,
                  color: AppColors.black,
                ),
              ),
              Text(
                title,
                style: AppText.text1,
              ),
              SvgIcon(
                icon: icon,
                size: 30,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
