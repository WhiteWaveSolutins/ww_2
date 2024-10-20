import 'package:ww_2/data/models/local_barcode/local_barcode.dart';

abstract class LocalCodeRepository {
  Future<List<LocalBarcode>> getSavedCodes();

  Future<bool> addSavedCodes({required LocalBarcode code});

  Future<bool> deleteSavedCodes({required LocalBarcode code});

  Future<bool> deleteHistoryCodes({required LocalBarcode code});

  Future<bool> updateSavedCodes({required LocalBarcode code});

  Future<List<LocalBarcode>> getHistoryCodes();

  Future<bool> addHistoryCodes({required LocalBarcode code});

  Future<bool> deleteHistory();
}
