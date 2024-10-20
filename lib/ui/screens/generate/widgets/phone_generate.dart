import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/modals/pick_country_modal.dart';

String convertFlag(String countryCode) {
  if (countryCode.isEmpty) return '';
  return countryCode.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(
          match.group(0)!.codeUnitAt(0) + 127397,
        ),
      );
}

class PhoneGenerate extends StatefulWidget {
  final Function(bool) changeActive;
  final TextEditingController controller;

  const PhoneGenerate({
    super.key,
    required this.changeActive,
    required this.controller,
  });

  @override
  State<PhoneGenerate> createState() => _PhoneGenerateState();
}

class _PhoneGenerateState extends State<PhoneGenerate> {
  late CountryWithPhoneCode code;
  bool active = false;

  @override
  void initState() {
    super.initState();
    code = const CountryWithPhoneCode.us();
  }

  String getMask(CountryWithPhoneCode? phone) {
    if (phone == null) return '';
    final mask = phone.phoneMaskMobileInternational.replaceAll('+', '');
    final data = mask.split(' ')..removeAt(0);
    return '${phone.phoneCode} ${data.join(' ')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: AppText.text2.copyWith(
            color: AppColors.white,
          ),
          controller: widget.controller,
          inputFormatters: [
            MaskTextInputFormatter(
              mask: getMask(code).replaceAll('0', '#'),
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy,
            ),
          ],
          keyboardType: TextInputType.number,
          onChanged: (text) {
            final maskLen = code.phoneMaskMobileInternational.replaceAll('+', '').length;
            final status = maskLen == text.length;
            if (active != status) {
              active = status;
              widget.changeActive(active);
            }
          },
          decoration: InputDecoration(
            hintText: code.phoneMaskMobileInternational.replaceAll('+', ''),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        constraints: BoxConstraints(
                          minHeight: 100,
                          maxHeight: MediaQuery.of(context).size.height - 50,
                        ),
                        backgroundColor: Colors.transparent,
                        builder: (_) => PickCountryModal(
                          pickCountry: (c) => setState(() => code = c),
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        convertFlag(code.countryCode),
                        style: AppText.text1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '+',
                    style: AppText.text2.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
