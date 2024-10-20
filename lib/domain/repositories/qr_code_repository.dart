import 'package:ww_2/data/models/answer/answer.dart';
import 'package:ww_2/data/models/config_customize.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';

abstract class QrCodeRepository {
  Future<Answer<QrCodeGenerate>> create({required DataQrCode data});

  Future<Answer<QrCodeGenerate>> customize({
    required DataQrCode data,
    required ConfigCustomize config,
  });

  Future<List<QrCodeGenerate>> getCrated();

  Future<bool> update({required QrCodeGenerate code});

  Future<bool> save({required QrCodeGenerate code});

  Future<bool> delete({required QrCodeGenerate code});
}
