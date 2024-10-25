import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:intl/intl.dart';

class CreatedCodeCard extends StatelessWidget {
  final QrCodeGenerate qr;

  const CreatedCodeCard({
    super.key,
    required this.qr,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 1,
      onPressed: () => getItService.navigatorService.onQrCode(qr: qr),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(.2),
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  qr.image,
                  width: 65,
                  height: 65,
                ),
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
                      qr.created == null ? '-' : DateFormat('dd/mm/yyyy').format(qr.created!),
                      style: AppText.text3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    qr.data.custom.join(' '),
                    style: AppText.text16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
