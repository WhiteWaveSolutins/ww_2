import 'package:flutter/material.dart';
import 'package:ww_2/domain/enums/safety_type.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';

class SafetySelect extends StatelessWidget {
  final TabController controller;

  const SafetySelect({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: AppColors.white.withOpacity(.2),
      ),
      child: TabBar(
        onTap: (_) {},
        controller: controller,
        dividerColor: Colors.transparent,
        labelColor: AppColors.black,
        unselectedLabelColor: Colors.white,
        splashBorderRadius: BorderRadius.circular(9),
        overlayColor: WidgetStateProperty.all<Color>(
          Colors.transparent,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: const LinearGradient(
            colors: [
              AppColors.yellowGrad1,
              AppColors.yellowGrad2,
            ],
          ),
        ),
        labelStyle: AppText.text3,
        unselectedLabelStyle: AppText.text3,
        tabs: SafetyType.values.map((e) => Tab(text: safetyTypeToString(e))).toList(),
      ),
    );
  }
}