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
        width: double.infinity,
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
          child: Column(
            children: [
              const SizedBox(height: 10),
              SvgIcon(
                icon: icon,
                size: 50,
                color: AppColors.black,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppText.text1,
              ),
              const SizedBox(height: 13),
            ],
          ),
        ),
      ),
    );
  }
}
