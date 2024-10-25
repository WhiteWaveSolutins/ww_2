import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_generate.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';

class GenerateDescriptionEventScreen extends StatefulWidget {
  const GenerateDescriptionEventScreen({super.key});

  @override
  State<GenerateDescriptionEventScreen> createState() => _GenerateDescriptionEventScreenState();
}

class _GenerateDescriptionEventScreenState extends State<GenerateDescriptionEventScreen> {
  final textController = TextEditingController();
  final nameController = TextEditingController();
  final eventController = TextEditingController();
  final dateController = TextEditingController();

  bool checkEvent = false;
  bool checkDate = false;
  bool checkName = false;

  @override
  void initState() {
    super.initState();

    nameController.addListener(() {
      if (checkName && nameController.text.isEmpty) {
        checkName = false;
        setState(() {});
      } else if (!checkName && nameController.text.isNotEmpty) {
        checkName = true;
        setState(() {});
      }
    });

    eventController.addListener(() {
      if (checkEvent && eventController.text.isEmpty) {
        checkEvent = false;
        setState(() {});
      } else if (!checkEvent && eventController.text.isNotEmpty) {
        checkEvent = true;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    eventController.dispose();
    dateController.dispose();
    nameController.dispose();
    textController.dispose();
    super.dispose();
  }

  void generate() {
    final data = DataQrCode(
      type: TypeGenerate.event,
      name: nameController.text,
      text: textController.text,
      event: eventController.text,
    );
    getItService.navigatorService.onGenerateResult(data: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GENERATE'),
        centerTitle: true,
        leading: const LeftButton(),
      ),
      bottomSheet: Container(
        color: AppColors.black,
        padding: const EdgeInsets.only(
          bottom: 20,
          right: 16,
          left: 16,
        ),
        child: MainButton(
          title: 'Create',
          onPressed: (checkName && checkDate && checkEvent) ? generate : null,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Event Name',
            style: AppText.text3,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: nameController,
            style: AppText.text2.copyWith(
              color: AppColors.white,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter name',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Date',
            style: AppText.text3,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: dateController,
            readOnly: true,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return SizedBox(
                    height: 500,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (date) {
                        dateController.text =
                            '${date.day}/${date.month >= 10 ? '' : '0'}${date.month}/${date.year}';
                        checkDate = true;
                      },
                      initialDateTime: DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                    ),
                  );
                },
              );
            },
            style: AppText.text2.copyWith(
              color: AppColors.white,
            ),
            decoration: const InputDecoration(hintText: '00/00/00'),
          ),
          const SizedBox(height: 16),
          Text(
            'Event location',
            style: AppText.text3,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: eventController,
            style: AppText.text2.copyWith(
              color: AppColors.white,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter address',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Description',
            style: AppText.text3,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: textController,
            style: AppText.text2.copyWith(
              color: AppColors.white,
            ),
            maxLines: null,
            minLines: 5,
            decoration: const InputDecoration(
              hintText: 'Enter note',
            ),
          ),
        ],
      ),
    );
  }
}
