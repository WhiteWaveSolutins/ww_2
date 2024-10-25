import 'package:flutter/material.dart';
import 'package:ww_2/ui/resurses/colors.dart';

class BoxActive extends StatelessWidget {
  const BoxActive({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.white,
        ),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
      ),
    );
  }
}
