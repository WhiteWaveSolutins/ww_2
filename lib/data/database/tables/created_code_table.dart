import 'package:drift/drift.dart';

class CreatedCodeTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get data => text()();

  TextColumn get image => text()();

  DateTimeColumn get created => dateTime()();
}
