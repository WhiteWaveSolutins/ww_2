import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ww_2/data/api/api.dart';
import 'package:ww_2/data/api/api_routers.dart';
import 'package:ww_2/data/database/database.dart';
import 'package:ww_2/data/models/answer/answer.dart';
import 'package:ww_2/data/models/config_customize.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';
import 'package:ww_2/domain/repositories/qr_code_repository.dart';

class ApiQrCodeRepository implements QrCodeRepository {
  final Api _client;
  final AppDataBase _dataBase;

  ApiQrCodeRepository({
    required Api api,
    required AppDataBase dataBase,
  })  : _client = api,
        _dataBase = dataBase;

  @override
  Future<List<QrCodeGenerate>> getCrated() => _dataBase.getCreatedCodes();

  @override
  Future<bool> save({required QrCodeGenerate code}) async {
    await _dataBase.addCreatedCodes(code: code);
    return true;
  }

  @override
  Future<bool> delete({required QrCodeGenerate code}) async {
    await _dataBase.deleteCreatedCode(code: code);
    return true;
  }

  @override
  Future<bool> update({required QrCodeGenerate code}) async {
    await _dataBase.updateCreatedCode(code: code);
    return true;
  }

  @override
  Future<Answer<QrCodeGenerate>> create({required DataQrCode data}) async {
    Response response;
    try {
      response = await _client.api.get(
        ApiRouters.custom,
        options: Options(responseType: ResponseType.bytes),
        queryParameters: {
          'data': data.data,
          'file': 'png',
        },
      );
    } on DioException catch (e) {
      return Answer(error: e.message);
    }

    try {
      final bytes = Uint8List.fromList(response.data);
      final qr = QrCodeGenerate(
        image: bytes,
        data: data,
        created: DateTime.now(),
      );
      return Answer(data: qr);
    } catch (e) {
      return Answer(error: 'TypeError');
    }
  }

  @override
  Future<Answer<QrCodeGenerate>> customize({
    required DataQrCode data,
    required ConfigCustomize config,
  }) async {
    Response response;
    try {
      response = await _client.api.post(
        ApiRouters.custom,
        options: Options(responseType: ResponseType.bytes),
        data: {
          'data': data.data,
          'config': config.toJson(),
          'file': 'png',
        },
      );
    } on DioException catch (e) {
      return Answer(error: e.message);
    }

    try {
      final bytes = Uint8List.fromList(response.data);
      final qr = QrCodeGenerate(
        image: bytes,
        data: data,
        created: DateTime.now(),
      );
      return Answer(data: qr);
    } catch (e) {
      return Answer(error: 'TypeError');
    }
  }
}
