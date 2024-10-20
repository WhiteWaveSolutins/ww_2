import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';

class CloseButton2 extends StatelessWidget {
  final Function()? onClose;
  final Color? backgroundColor;
  final Color? iconColor;

  const CloseButton2({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onClose ?? getItService.navigatorService.onPop,
      minSize: 1,
      padding: EdgeInsets.zero,
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? AppColors.grey,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.clear,
          size: 15,
          color: iconColor ?? AppColors.white,
        ),
      ),
    );
  }
}
