import 'package:flutter/cupertino.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const MainButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      minSize: 1,
      padding: EdgeInsets.zero,
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.grey,
          gradient: onPressed == null
              ? null
              : const LinearGradient(
                  colors: [
                    AppColors.yellowGrad1,
                    AppColors.yellowGrad2,
                  ],
                ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppText.text1,
          ),
        ),
      ),
    );
  }
}
