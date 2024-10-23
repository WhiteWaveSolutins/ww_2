import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as ms;
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/state.dart';
import 'package:ww_2/ui/widgets/app_barcode.dart';
import 'package:ww_2/ui/widgets/buttons/simple_button.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';
import 'package:ww_2/ui/widgets/gradient_widget.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessfullyScan extends StatelessWidget {
  final ms.BarcodeCapture barcode;

  const SuccessfullyScan({
    super.key,
    required this.barcode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: getItService.navigatorService.onPop,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.clear,
                    size: 15,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppBarcode(
            padding: (barcode.barcodes.firstOrNull?.format ?? ms.BarcodeFormat.qrCode) !=
                    ms.BarcodeFormat.qrCode
                ? 20
                : 5,
            data: LocalBarcodeData(
              data: barcode.barcodes.firstOrNull?.displayValue ?? '',
              format: barcode.barcodes.firstOrNull?.format ?? ms.BarcodeFormat.qrCode,
            ),
          ),
          const SizedBox(height: 16),
          GradientWidget.primary(
            const SvgIcon(
              icon: AppIcons.fire,
              size: 50,
            ),
          ),
          const SizedBox(height: 8),
          GradientText.primary(
            'Successfully',
            style: AppText.h1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          StoreConnector<AppState, SubscriptionState>(
            converter: (store) => store.state.subscriptionState,
            builder: (context, state) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SimpleButton(
                      onTap: () async {
                        if (!state.hasPremium) {
                          getItService.navigatorService.onGetPremium();
                          return;
                        }
                        final url = Uri.parse(barcode.barcodes.firstOrNull?.displayValue ?? '');
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      title: 'Open in browser',
                      icon: AppIcons.globe,
                      centerTitle: true,
                    ),
                  ),
                  if (!state.hasPremium)
                    Image.asset(
                      AppImages.almaz,
                      width: 40,
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SimpleButton(
                  onTap: Navigator.of(context).pop,
                  title: 'Again',
                  centerTitle: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SimpleButton(
                  onTap: () {
                    getItService.navigatorService.onFirst();
                    getItService.navigatorService.onSaveCode(
                      barcode: LocalBarcode(
                        data: barcode.barcodes.firstOrNull?.displayValue ?? '',
                        format: barcode.barcodes.firstOrNull?.format ?? ms.BarcodeFormat.qrCode,
                      ),
                    );
                  },
                  title: 'Save',
                  icon: AppIcons.starSolid,
                  gradient: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
