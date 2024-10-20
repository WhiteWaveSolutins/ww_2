import 'dart:typed_data';

import 'package:ww_2/data/database/database.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';

class QrCodeGenerate {
  final DataQrCode data;
  final Uint8List image;
  final DateTime? created;

  QrCodeGenerate({
    required this.data,
    required this.image,
    this.created,
  });

  factory QrCodeGenerate.fromTableData(CreatedCodeTableData data) {
    final list = data.image.toString().replaceAll('[', '').replaceAll(']', '');
    final ints = list.split(',').toList();
    final nums = ints.map((e) => int.parse(e)).toList();
    return QrCodeGenerate(
      data: DataQrCode.fromTableData(data.data),
      created: data.created,
      image: Uint8List.fromList(nums),
    );
  }
}
