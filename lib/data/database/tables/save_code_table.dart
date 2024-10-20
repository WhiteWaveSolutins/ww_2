import 'package:drift/drift.dart';

class SaveCodeTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get format => text()();

  TextColumn get type => text().nullable()();

  DateTimeColumn get created => dateTime()();

  IntColumn get color => integer().nullable()();

  TextColumn get data => text()();
}
