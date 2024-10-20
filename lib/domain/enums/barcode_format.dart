import 'package:mobile_scanner/mobile_scanner.dart';

BarcodeFormat toBarcodeFormat(String type) {
  final map = {
    'qrCode': BarcodeFormat.qrCode,
    'ean13': BarcodeFormat.ean13,
    'ean8': BarcodeFormat.ean8,
    'upcE': BarcodeFormat.upcE,
    'upcA': BarcodeFormat.upcA,
  };
  return map[type] ?? BarcodeFormat.qrCode;
}
