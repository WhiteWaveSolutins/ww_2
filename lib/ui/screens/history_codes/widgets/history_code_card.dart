import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/app_barcode.dart';

class HistoryCodeCard extends StatelessWidget {
  final LocalBarcode localBarcode;

  const HistoryCodeCard({
    super.key,
    required this.localBarcode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getItService.navigatorService.onSaveCode(barcode: localBarcode),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            AppBarcode(
              data: localBarcode.barcodeData,
              size: localBarcode.format != BarcodeFormat.qrCode ? 45 : 65,
              radius: 20,
              padding: localBarcode.format != BarcodeFormat.qrCode ? 10 : 0,
              textStyle: AppText.small.copyWith(
                fontSize: 6,
              ),
              border: true,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                localBarcode.created == null
                    ? '-'
                    : DateFormat('dd/mm/yyyy').format(localBarcode.created!),
                style: AppText.text16,
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
                CupertinoIcons.plus,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
