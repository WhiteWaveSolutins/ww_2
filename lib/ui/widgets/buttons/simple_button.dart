import 'package:flutter/cupertino.dart';
import 'package:gaimon/gaimon.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/gradient_widget.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class SimpleButton extends StatelessWidget {
  final String? icon;
  final Widget? iconWidget;
  final String title;
  final bool gradient;
  final bool centerTitle;
  final double height;
  final Function()? onTap;

  const SimpleButton({
    super.key,
    required this.title,
    this.icon,
    this.iconWidget,
    this.onTap,
    this.centerTitle = false,
    this.gradient = false,
    this.height = 70,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconBuild() {
      if (iconWidget != null) return iconWidget!;
      if (icon == null) return Container();
      if (gradient) {
        return SvgIcon(
          icon: icon!,
          size: 30,
          color: AppColors.black,
        );
      } else {
        return GradientWidget.primary(
          SvgIcon(
            icon: icon!,
            size: 30,
          ),
        );
      }
    }

    return CupertinoButton(
      onPressed: () {
        Gaimon.selection();
        onTap?.call();
      },
      minSize: 1,
      padding: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.grey,
              gradient: !gradient
                  ? null
                  : const LinearGradient(
                      colors: [
                        AppColors.yellowGrad1,
                        AppColors.yellowGrad2,
                      ],
                    ),
              borderRadius: BorderRadius.circular(20),
              border: gradient || onTap == null
                  ? null
                  : const Border(
                      bottom: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
            ),
            child: Row(
              mainAxisAlignment:
                  centerTitle ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppText.text1.copyWith(
                    color: gradient || onTap == null ? AppColors.black : AppColors.white,
                    height: 1,
                  ),
                ),
                if (!centerTitle) onTap == null ? GradientWidget.black(iconBuild()) : iconBuild(),
              ],
            ),
          ),
          if (centerTitle)
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: onTap == null ? GradientWidget.black(iconBuild()) : iconBuild(),
            ),
        ],
      ),
    );
  }
}
