import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as ms;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';

class AppBarcode extends StatelessWidget {
  final LocalBarcodeData data;
  final double size;
  final double padding;
  final Color? color;
  final double radius;
  final bool border;
  final TextStyle? textStyle;

  const AppBarcode({
    super.key,
    required this.data,
    this.textStyle,
    this.color,
    this.size = 200,
    this.radius = 16,
    this.padding = 5,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(radius),
        border: border ? Border.all(color: AppColors.primary) : null,
      ),
      child: data.format != ms.BarcodeFormat.qrCode
          ? BarcodeWidget(
              barcode: data.format == ms.BarcodeFormat.ean13
                  ? Barcode.ean13()
                  : data.format == ms.BarcodeFormat.ean8
                      ? Barcode.ean8()
                      : data.format == ms.BarcodeFormat.upcE
                          ? Barcode.upcE()
                          : Barcode.upcA(),
              data: data.data,
              width: size,
              height: size,
              color: color ?? data.color ?? AppColors.black,
              style: (textStyle ?? AppText.small).copyWith(
                color: color ?? data.color ?? AppColors.black,
              ),
            )
          : QrImageView(
              data: data.data,
              version: QrVersions.auto,
              size: size,
              eyeStyle: QrEyeStyle(
                color: color ?? data.color ?? AppColors.black,
                eyeShape: QrEyeShape.square,
              ),
              dataModuleStyle: QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: color ?? data.color ?? AppColors.black,
              ),
            ),
    );
  }
}
