import 'package:flutter/material.dart';
import 'package:ww_2/domain/enums/type_code.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';

class FilterTypeCode extends StatelessWidget {
  final TypeCode? type;
  final bool selected;
  final Function() onTap;

  const FilterTypeCode({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.only(bottom: 3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              color: !selected ? Colors.transparent : AppColors.primary,
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            if (type != null) ...[
              Text(
                typeCodeToIcon(type!),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              type != null ? typeCodeToString(type!) : 'All',
              style: AppText.text3,
            ),
          ],
        ),
      ),
    );
  }
}
