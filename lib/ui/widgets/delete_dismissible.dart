import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ww_2/ui/resurses/colors.dart';

class DeleteDismissible extends StatelessWidget {
  final Widget child;
  final Function() onDelete;

  const DeleteDismissible({
    super.key,
    required this.child,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (d) {
        if (DismissDirection.endToStart == d) onDelete();
      },
      secondaryBackground: Container(
        color: AppColors.red,
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Icon(
            CupertinoIcons.trash,
            color: AppColors.white,
          ),
        ),
      ),
      background: Container(color: Colors.red),
      key:UniqueKey(),
      child: child,
    );
  }
}
