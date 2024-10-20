import 'dart:ui';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ww_2/data/database/database.dart';
import 'package:ww_2/domain/enums/barcode_format.dart';
import 'package:ww_2/domain/enums/type_code.dart';

class LocalBarcode {
  final String data;
  final DateTime? created;
  final String title;
  final TypeCode? type;
  final BarcodeFormat format;
  final int? color;

  LocalBarcode({
    required this.data,
    required this.format,
    this.type,
    this.color,
    this.created,
    this.title = '',
  });

  factory LocalBarcode.fromSaveCodeTableData(SaveCodeTableData data) => LocalBarcode(
        data: data.data,
        type: data.type == null ? null : typeCodeToData(data.type!),
        color: data.color,
        title: data.title,
        created: data.created,
        format: toBarcodeFormat(data.format),
      );

  factory LocalBarcode.fromHistoryCodeTableData(HistoryCodeTableData data) => LocalBarcode(
        data: data.data,
        created: data.created,
        format: toBarcodeFormat(data.format),
      );

  Color? get colors => color != null ? Color(color!) : null;

  LocalBarcodeData get barcodeData {
    return LocalBarcodeData(
      data: data,
      format: format,
      color: colors,
    );
  }
}

class LocalBarcodeData {
  final String data;
  final BarcodeFormat format;
  final Color? color;

  LocalBarcodeData({
    required this.data,
    required this.format,
    this.color,
  });
}
