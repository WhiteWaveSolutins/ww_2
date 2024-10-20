import 'package:flutter/material.dart';
import 'package:ww_2/domain/enums/customize.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/buttons/close_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';

class PickerBodyModal extends StatefulWidget {
  final Function(CustomizeBody?) pickBody;
  final CustomizeBody? selectedBody;

  const PickerBodyModal({
    super.key,
    required this.pickBody,
    this.selectedBody,
  });

  @override
  State<PickerBodyModal> createState() => _PickerBodyModalState();
}

class _PickerBodyModalState extends State<PickerBodyModal> {
  late CustomizeBody? body;

  @override
  void initState() {
    super.initState();
    body = widget.selectedBody;
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
                  'Select Points',
                  style: AppText.text16.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 18,
                    mainAxisExtent: 72,
                    mainAxisSpacing: 18,
                    crossAxisCount: 4,
                    crossAxisSpacing: 18,
                  ),
                  itemCount: CustomizeBody.values.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => setState(() => body = CustomizeBody.values[index]),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        gradient: body != CustomizeBody.values[index]
                            ? null
                            : const LinearGradient(
                                colors: [
                                  AppColors.yellowGrad1,
                                  AppColors.yellowGrad2,
                                ],
                              ),
                        border: Border.all(
                          color: body == CustomizeBody.values[index]
                              ? Colors.transparent
                              : AppColors.grey.withOpacity(.2),
                        ),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Image.asset(
                        enumCustomizeIcon(
                          CustomizeBody.values[index].name,
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
                  widget.pickBody(body);
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
