import 'package:drift/drift.dart';

class HistoryCodeTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get data => text()();

  TextColumn get format => text()();

  DateTimeColumn get created => dateTime()();
}
