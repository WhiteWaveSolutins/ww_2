import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_code.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/app_barcode.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';
import 'package:intl/intl.dart';

class SavedCodeCard extends StatelessWidget {
  final LocalBarcode localBarcode;

  const SavedCodeCard({
    super.key,
    required this.localBarcode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getItService.navigatorService.onLocalCode(barcode: localBarcode),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(.2),
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            AppBarcode(
              data: localBarcode.barcodeData,
              border: true,
              size: localBarcode.format != BarcodeFormat.qrCode ? 45 : 65,
              radius: 20,
              padding: localBarcode.format != BarcodeFormat.qrCode ? 10 : 0,
              textStyle: AppText.small.copyWith(
                fontSize: 6,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: .5,
                    child: Text(
                      localBarcode.created == null
                          ? '-'
                          : DateFormat('dd/mm/yyyy').format(localBarcode.created!),
                      style: AppText.text3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    localBarcode.title,
                    style: AppText.text16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  if (localBarcode.type != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          typeCodeToIcon(localBarcode.type!),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 6),
                        GradientText.primary(
                          typeCodeToString(localBarcode.type!),
                          style: AppText.text3,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.yellowGrad1,
                    AppColors.yellowGrad2,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
