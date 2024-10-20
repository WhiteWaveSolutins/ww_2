import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart' as drift;
import 'package:ww_2/data/database/tables/created_code_table.dart';
import 'package:ww_2/data/database/tables/history_code_table.dart';
import 'package:ww_2/data/database/tables/save_code_table.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';
import 'package:talker/talker.dart';

part 'database.g.dart';

void _log(String message) {
  Talker().logTyped(
    TalkerLog(
      message,
      title: 'DATABASE',
      logLevel: LogLevel.info,
    ),
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'database3'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  SaveCodeTable,
  HistoryCodeTable,
  CreatedCodeTable,
])
class AppDataBase extends _$AppDataBase {
  AppDataBase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  //Created
  Future<List<QrCodeGenerate>> getCreatedCodes() async {
    final list = await select(createdCodeTable).get();
    _log('Get Created codes');
    return list.map((e) => QrCodeGenerate.fromTableData(e)).toList();
  }

  Future<void> addCreatedCodes({required QrCodeGenerate code}) async {
    final companion = CreatedCodeTableCompanion(
      data: drift.Value(code.data.toDataForDataBase()),
      image: drift.Value(code.image.toString()),
      created: drift.Value(code.created ?? DateTime.now()),
    );
    await into(createdCodeTable).insert(companion);
    _log('Add Created code');
  }

  Future<void> deleteCreatedCode({required QrCodeGenerate code}) async {
    await (delete(createdCodeTable)..where((t) => t.data.isIn([code.data.toDataForDataBase()]))).go();
    _log('Delete Created code');
  }

  Future<void> updateCreatedCode({required QrCodeGenerate code}) async {
    await (update(createdCodeTable)..where((tbl) => tbl.data.isIn([code.data.toDataForDataBase()]))).write(
      CreatedCodeTableCompanion(
        data: drift.Value(code.data.toDataForDataBase()),
        image: drift.Value(code.image.toString()),
        created: drift.Value(code.created ?? DateTime.now()),
      ),
    );
    _log('Update Created code');
  }

  //Saved
  Future<List<LocalBarcode>> getSavedCodes() async {
    final list = await select(saveCodeTable).get();
    _log('Get saved codes');
    return list.map((e) => LocalBarcode.fromSaveCodeTableData(e)).toList();
  }

  Future<void> addSavedCodes({required LocalBarcode code}) async {
    final companion = SaveCodeTableCompanion(
      color: drift.Value(code.color),
      data: drift.Value(code.data),
      created: drift.Value(code.created ?? DateTime.now()),
      title: drift.Value(code.title),
      type: drift.Value(code.type?.name),
      format: drift.Value(code.format.name),
    );
    await into(saveCodeTable).insert(companion);
    _log('Add saved code');
  }

  Future<void> deleteSaveCode({required LocalBarcode code}) async {
    await (delete(saveCodeTable)..where((t) => t.data.isIn([code.data]))).go();
    _log('Delete save code');
  }

  Future<void> updateSavedCode({required LocalBarcode code}) async {
    await (update(saveCodeTable)..where((tbl) => tbl.data.isIn([code.data]))).write(
      SaveCodeTableCompanion(
        color: drift.Value(code.color),
        type: drift.Value(code.type?.name),
        created: drift.Value(code.created ?? DateTime.now()),
        data: drift.Value(code.data),
        title: drift.Value(code.title),
        format: drift.Value(code.format.name),
      ),
    );
    _log('Update saved code');
  }

  //History
  Future<List<LocalBarcode>> getHistoryCodes() async {
    final list = await select(historyCodeTable).get();
    _log('Get history code');
    return list.map((e) => LocalBarcode.fromHistoryCodeTableData(e)).toList();
  }

  Future<void> addHistoryCodes({required LocalBarcode code}) async {
    final companion = HistoryCodeTableCompanion(
      data: drift.Value(code.data),
      created: drift.Value(code.created ?? DateTime.now()),
      format: drift.Value(code.format.name),
    );
    await into(historyCodeTable).insert(companion);
    _log('Add history code');
  }

  Future<void> deleteHistoryCode({required LocalBarcode code}) async {
    await (delete(historyCodeTable)..where((t) => t.data.isIn([code.data]))).go();
    _log('Delete history code');
  }

  Future<void> deleteHistoryAll() async {
    await (delete(historyCodeTable)..where((t) => t.data.isNotNull())).go();
    _log('Delete history all codes');
  }
}
