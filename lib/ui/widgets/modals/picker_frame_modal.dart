import 'package:flutter/material.dart';
import 'package:ww_2/domain/enums/customiza_frame.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/buttons/close_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';

class PickerFrameModal extends StatefulWidget {
  final Function(CustomizeFrame?) pickFrame;
  final CustomizeFrame? selectedFrame;

  const PickerFrameModal({
    super.key,
    required this.pickFrame,
    this.selectedFrame,
  });

  @override
  State<PickerFrameModal> createState() => _PickerFrameModalState();
}

class _PickerFrameModalState extends State<PickerFrameModal> {
  late CustomizeFrame? frame;

  @override
  void initState() {
    super.initState();
    frame = widget.selectedFrame;
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
                  'Select Pattern',
                  style: AppText.text16.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8,
                    mainAxisExtent: 120,
                    mainAxisSpacing: 8,
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: CustomizeFrame.values.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () =>
                        setState(() => frame = CustomizeFrame.values[index]),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 3,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        gradient: frame != CustomizeFrame.values[index]
                            ? null
                            : const LinearGradient(
                                colors: [
                                  AppColors.yellowGrad1,
                                  AppColors.yellowGrad2,
                                ],
                              ),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            customizeFrameIcon(CustomizeFrame.values[index]),
                            width: 81,
                            height: 81,
                          ),
                          Text(
                            customizeFrameTitle(CustomizeFrame.values[index]),
                            textAlign: TextAlign.center,
                            style: AppText.small.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              MainButton(
                title: 'Apply',
                onPressed: () {
                  widget.pickFrame(frame);
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
