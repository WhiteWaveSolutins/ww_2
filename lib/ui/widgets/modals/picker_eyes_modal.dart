import 'package:flutter/material.dart';
import 'package:ww_2/domain/enums/customize.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/buttons/close_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';

class PickerEyeModal extends StatefulWidget {
  final Function(
    CustomizeEye?,
    CustomizeEyeBall?,
  ) pickEye;
  final CustomizeEye? selectedEye;
  final CustomizeEyeBall? selectedEyeBall;

  const PickerEyeModal({
    super.key,
    required this.pickEye,
    this.selectedEye,
    this.selectedEyeBall,
  });

  @override
  State<PickerEyeModal> createState() => _PickerEyeModalState();
}

class _PickerEyeModalState extends State<PickerEyeModal> {
  late CustomizeEye? eye;
  late CustomizeEyeBall? eyeBall;
  bool isEye = true;

  @override
  void initState() {
    super.initState();
    eye = widget.selectedEye;
    eyeBall = widget.selectedEyeBall;
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Select Code eyes',
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
                    onTap: () => setState(() => isEye = true),
                    child: AnimatedOpacity(
                      opacity: isEye ? 1 : .3,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        'Eye',
                        style: AppText.text3.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => isEye = false),
                    child: AnimatedOpacity(
                      opacity: isEye ? .3 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        'EyeBall',
                        style: AppText.text3.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 18,
                    mainAxisExtent: 72,
                    mainAxisSpacing: 18,
                    crossAxisCount: 4,
                    crossAxisSpacing: 18,
                  ),
                  itemCount: isEye ? CustomizeEye.values.length : CustomizeEyeBall.values.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      if (isEye) {
                        eye = CustomizeEye.values[index];
                      } else {
                        eyeBall = CustomizeEyeBall.values[index];
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        gradient: (isEye
                                ? (eye != CustomizeEye.values[index])
                                : (eyeBall != CustomizeEyeBall.values[index]))
                            ? null
                            : const LinearGradient(
                                colors: [
                                  AppColors.yellowGrad1,
                                  AppColors.yellowGrad2,
                                ],
                              ),
                        border: Border.all(
                          color: (isEye
                                  ? (eye == CustomizeEye.values[index])
                                  : (eyeBall == CustomizeEyeBall.values[index]))
                              ? Colors.transparent
                              : AppColors.grey.withOpacity(.2),
                        ),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Image.asset(
                        enumCustomizeIcon(
                          (isEye ? CustomizeEye.values : CustomizeEyeBall.values)[index].name,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              MainButton(
                title: 'Apply',
                onPressed: () {
                  widget.pickEye(eye, eyeBall);
                  Navigator.of(context).pop();
                },
              ),
            ],
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
