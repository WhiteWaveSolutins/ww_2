import 'package:flutter/material.dart';
import 'package:ww_2/data/data_colors.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/buttons/close_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class PickerColorsModal extends StatefulWidget {
  final Function(
    Color?,
    Color?,
  ) pickColors;
  final Color? selectedColor;
  final Color? selectedBackColor;

  const PickerColorsModal({
    super.key,
    required this.pickColors,
    this.selectedColor,
    this.selectedBackColor,
  });

  @override
  State<PickerColorsModal> createState() => _PickerColorsModalState();
}

class _PickerColorsModalState extends State<PickerColorsModal> {
  late Color? color;
  late Color? back;
  bool isView = true;

  @override
  void initState() {
    super.initState();
    color = widget.selectedColor;
    back = widget.selectedBackColor;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Select color',
                    style: AppText.text16.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => isView = true),
                      child: AnimatedOpacity(
                        opacity: isView ? 1 : .3,
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          'Front view',
                          style: AppText.text3.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => isView = false),
                      child: AnimatedOpacity(
                        opacity: isView ? .3 : 1,
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          'Background',
                          style: AppText.text3.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                for (int i = 0; i < 10; i++)
                  Builder(builder: (context) {
                    final colors = DataColors.colors.sublist(i * 10, (i * 10) + 10);
                    return Column(
                      children: [
                        Row(
                          children: [
                            for (int j = 0; j < colors.length; j++)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (isView) {
                                      color = colors[j];
                                    } else {
                                      back = colors[j];
                                    }
                                    setState(() {});
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: colors[j],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(i == 0 && j == 0 ? 16 : 0),
                                            topRight: Radius.circular(
                                              i == 0 && j == colors.length - 1 ? 16 : 0,
                                            ),
                                            bottomRight: Radius.circular(
                                              i == 9 && j == colors.length - 1 ? 16 : 0,
                                            ),
                                            bottomLeft: Radius.circular(
                                              i == 9 && j == 0 ? 16 : 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (isView ? color == colors[j] : back == colors[j])
                                        Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.white,
                                            border: Border.all(color: AppColors.black),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    );
                  }),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: isView ? color : back,
                        border: (isView ? color : back) != null
                            ? null
                            : Border.all(color: AppColors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(30),
                      child: (isView ? color : back) == null
                          ? const SvgIcon(icon: AppIcons.close)
                          : Container(),
                    ),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: () {
                        if (isView) {
                          color = null;
                        } else {
                          back = null;
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.black),
                          color: Colors.transparent,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.clear,
                          size: 15,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                MainButton(
                  title: 'Apply',
                  onPressed: () {
                    widget.pickColors(color, back);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, right: 16),
          child: CloseButton2(
            onClose: Navigator.of(context).pop,
            iconColor: AppColors.black,
            backgroundColor: AppColors.grey.withOpacity(.4),
          ),
        ),
      ],
    );
  }
}
