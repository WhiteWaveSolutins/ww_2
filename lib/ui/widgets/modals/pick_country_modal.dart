import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart' as cp;
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/generate/widgets/phone_generate.dart';
import 'package:ww_2/ui/widgets/buttons/close_button.dart';

class PickCountryModal extends StatefulWidget {
  final Function(CountryWithPhoneCode) pickCountry;

  const PickCountryModal({
    super.key,
    required this.pickCountry,
  });

  @override
  State<PickCountryModal> createState() => _PickCountryModalState();
}

class _PickCountryModalState extends State<PickCountryModal> {
  bool isLoading = true;
  var countries = <CountryWithPhoneCode>[];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    await cp.init();
    countries = cp.CountryManager().countries;
    setState(() => isLoading = false);
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
            children: [
              Text(
                'Select country',
                style: AppText.text16.copyWith(
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                child: TextField(
                  style: AppText.text2.copyWith(
                    color: AppColors.black,
                  ),
                  onChanged: (data) {
                    if (data.isEmpty) {
                      countries = cp.CountryManager().countries;
                    } else {
                      countries = cp.CountryManager()
                          .countries
                          .where((e) =>
                              e.countryName?.toLowerCase().contains(data.toLowerCase()) ?? false)
                          .toList();
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: AppText.text2.copyWith(
                      color: AppColors.grey,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 2),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (isLoading)
                const Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                )
              else if (countries.isEmpty)
                Text(
                  'Nothing found.\nTry spelling it differently',
                  style: AppText.text16.copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                )
              else
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: countries.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        widget.pickCountry(countries[index]);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              convertFlag(countries[index].countryCode),
                              style: AppText.text1,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                countries[index].countryName ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.text16.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '+${countries[index].phoneCode}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.text16.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
