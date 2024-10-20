import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_code.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/app_barcode.dart';
import 'package:ww_2/ui/widgets/buttons/close_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';
import 'package:ww_2/ui/widgets/gradient_widget.dart';
import 'package:ww_2/ui/widgets/modals/picker_color_modal.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class SaveCodeScreen extends StatefulWidget {
  final LocalBarcode localBarcode;

  const SaveCodeScreen({
    super.key,
    required this.localBarcode,
  });

  @override
  State<SaveCodeScreen> createState() => _SaveCodeScreenState();
}

class _SaveCodeScreenState extends State<SaveCodeScreen> {
  late Color? color;
  late TextEditingController nameController;
  late TypeCode? selectedType;
  late bool activeButton;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.localBarcode.title);
    activeButton = nameController.text.isNotEmpty;
    color = widget.localBarcode.colors;
    selectedType = widget.localBarcode.type;
    nameController.addListener(() {
      if (activeButton && nameController.text.isEmpty) {
        activeButton = false;
        setState(() {});
      } else if (!activeButton && nameController.text.isNotEmpty) {
        activeButton = true;
        setState(() {});
      }
    });
  }

  void save() {
    final data = LocalBarcode(
      data: widget.localBarcode.data,
      format: widget.localBarcode.format,
      created: widget.localBarcode.created ?? DateTime.now(),
      color: color?.value,
      type: selectedType,
      title: nameController.text,
    );
    if (widget.localBarcode.created == null) {
      getItService.localCodeUseCase.addSave(data);
    } else {
      getItService.localCodeUseCase.updateSave(data);
    }
    getItService.navigatorService.onFirst();
    getItService.navigatorService.onSavedCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SAVE CODE'),
        centerTitle: true,
        actions: const [CloseButton2()],
        leading: Container(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 20),
          Center(
            child: AppBarcode(
              padding: widget.localBarcode.format != BarcodeFormat.qrCode ? 15 : 5,
              data: widget.localBarcode.barcodeData,
              color: color,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Name',
            style: AppText.text3,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: nameController,
            style: AppText.text2.copyWith(
              color: AppColors.white,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter Name',
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ButtonColor(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    constraints: BoxConstraints(
                      minHeight: 100,
                      maxHeight: MediaQuery.of(context).size.height - 50,
                    ),
                    backgroundColor: Colors.transparent,
                    builder: (_) => PickerColorModal(
                      selectedColor: color,
                      pickColor: (c) => setState(() => color = c),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Type',
            style: AppText.text3,
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var type in [
                TypeCode.product,
                TypeCode.personalData,
                TypeCode.payment,
                TypeCode.webPages,
              ]) ...[
                _Type(
                  type: type,
                  selected: type == selectedType,
                  onTap: () => setState(() => selectedType = type),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var type in [
                TypeCode.tickets,
                TypeCode.geographicData,
                TypeCode.multimedia,
                TypeCode.other,
              ]) ...[
                _Type(
                  type: type,
                  selected: type == selectedType,
                  onTap: () => setState(() => selectedType = type),
                ),
              ],
            ],
          ),
          const SizedBox(height: 40),
          MainButton(
            title: 'Save',
            onPressed: activeButton ? save : null,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _Type extends StatelessWidget {
  final TypeCode type;
  final bool selected;
  final Function() onTap;

  const _Type({
    super.key,
    required this.type,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.all(15),
            width: (MediaQuery.of(context).size.width - 64) / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white.withOpacity(.2),
              border: Border(
                bottom: BorderSide(
                  color: selected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              typeCodeToIcon(type),
              style: const TextStyle(fontSize: 25),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 80,
            child: Opacity(
              opacity: .5,
              child: Text(
                typeCodeToString(type),
                style: AppText.text16.copyWith(height: 1),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonColor extends StatelessWidget {
  final Function() onTap;

  const _ButtonColor({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(20),
          border: const Border(
            bottom: BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Color',
              style: AppText.text1.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 16),
            GradientWidget.primary(
              const SvgIcon(
                icon: AppIcons.color,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
