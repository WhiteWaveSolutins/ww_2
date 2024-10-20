import 'package:ww_2/data/database/database.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/repositories/local_code_repository.dart';

class LocalLocalCodeRepository implements LocalCodeRepository {
  final AppDataBase database;

  LocalLocalCodeRepository({required this.database});

  @override
  Future<List<LocalBarcode>> getSavedCodes() => database.getSavedCodes();

  @override
  Future<bool> addSavedCodes({required LocalBarcode code}) async {
    await database.addSavedCodes(code: code);
    return true;
  }

  @override
  Future<bool> updateSavedCodes({required LocalBarcode code}) async {
    await database.updateSavedCode(code: code);
    return true;
  }

  @override
  Future<List<LocalBarcode>> getHistoryCodes() => database.getHistoryCodes();

  @override
  Future<bool> addHistoryCodes({required LocalBarcode code}) async {
    await database.addHistoryCodes(code: code);
    return true;
  }

  @override
  Future<bool> deleteHistoryCodes({required LocalBarcode code}) async {
    await database.deleteHistoryCode(code: code);
    return true;
  }

  @override
  Future<bool> deleteHistory() async {
    await database.deleteHistoryAll();
    return true;
  }

  @override
  Future<bool> deleteSavedCodes({required LocalBarcode code}) async {
    await database.deleteSaveCode(code: code);
    return true;
  }
}
