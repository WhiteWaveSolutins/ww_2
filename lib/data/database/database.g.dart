// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SaveCodeTableTable extends SaveCodeTable
    with drift.TableInfo<$SaveCodeTableTable, SaveCodeTableData> {
  @override
  final drift.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaveCodeTableTable(this.attachedDatabase, [this._alias]);
  static const drift.VerificationMeta _idMeta =
      const drift.VerificationMeta('id');
  @override
  late final drift.GeneratedColumn<int> id = drift.GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const drift.VerificationMeta _titleMeta =
      const drift.VerificationMeta('title');
  @override
  late final drift.GeneratedColumn<String> title =
      drift.GeneratedColumn<String>('title', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const drift.VerificationMeta _formatMeta =
      const drift.VerificationMeta('format');
  @override
  late final drift.GeneratedColumn<String> format =
      drift.GeneratedColumn<String>('format', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const drift.VerificationMeta _typeMeta =
      const drift.VerificationMeta('type');
  @override
  late final drift.GeneratedColumn<String> type = drift.GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const drift.VerificationMeta _createdMeta =
      const drift.VerificationMeta('created');
  @override
  late final drift.GeneratedColumn<DateTime> created =
      drift.GeneratedColumn<DateTime>('created', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const drift.VerificationMeta _colorMeta =
      const drift.VerificationMeta('color');
  @override
  late final drift.GeneratedColumn<int> color = drift.GeneratedColumn<int>(
      'color', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const drift.VerificationMeta _dataMeta =
      const drift.VerificationMeta('data');
  @override
  late final drift.GeneratedColumn<String> data = drift.GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<drift.GeneratedColumn> get $columns =>
      [id, title, format, type, created, color, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'save_code_table';
  @override
  drift.VerificationContext validateIntegrity(
      drift.Insertable<SaveCodeTableData> instance,
      {bool isInserting = false}) {
    final context = drift.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<drift.GeneratedColumn> get $primaryKey => {id};
  @override
  SaveCodeTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaveCodeTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color']),
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
    );
  }

  @override
  $SaveCodeTableTable createAlias(String alias) {
    return $SaveCodeTableTable(attachedDatabase, alias);
  }
}

class SaveCodeTableData extends drift.DataClass
    implements drift.Insertable<SaveCodeTableData> {
  final int id;
  final String title;
  final String format;
  final String? type;
  final DateTime created;
  final int? color;
  final String data;
  const SaveCodeTableData(
      {required this.id,
      required this.title,
      required this.format,
      this.type,
      required this.created,
      this.color,
      required this.data});
  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    map['id'] = drift.Variable<int>(id);
    map['title'] = drift.Variable<String>(title);
    map['format'] = drift.Variable<String>(format);
    if (!nullToAbsent || type != null) {
      map['type'] = drift.Variable<String>(type);
    }
    map['created'] = drift.Variable<DateTime>(created);
    if (!nullToAbsent || color != null) {
      map['color'] = drift.Variable<int>(color);
    }
    map['data'] = drift.Variable<String>(data);
    return map;
  }

  SaveCodeTableCompanion toCompanion(bool nullToAbsent) {
    return SaveCodeTableCompanion(
      id: drift.Value(id),
      title: drift.Value(title),
      format: drift.Value(format),
      type: type == null && nullToAbsent
          ? const drift.Value.absent()
          : drift.Value(type),
      created: drift.Value(created),
      color: color == null && nullToAbsent
          ? const drift.Value.absent()
          : drift.Value(color),
      data: drift.Value(data),
    );
  }

  factory SaveCodeTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return SaveCodeTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      format: serializer.fromJson<String>(json['format']),
      type: serializer.fromJson<String?>(json['type']),
      created: serializer.fromJson<DateTime>(json['created']),
      color: serializer.fromJson<int?>(json['color']),
      data: serializer.fromJson<String>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'format': serializer.toJson<String>(format),
      'type': serializer.toJson<String?>(type),
      'created': serializer.toJson<DateTime>(created),
      'color': serializer.toJson<int?>(color),
      'data': serializer.toJson<String>(data),
    };
  }

  SaveCodeTableData copyWith(
          {int? id,
          String? title,
          String? format,
          drift.Value<String?> type = const drift.Value.absent(),
          DateTime? created,
          drift.Value<int?> color = const drift.Value.absent(),
          String? data}) =>
      SaveCodeTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        format: format ?? this.format,
        type: type.present ? type.value : this.type,
        created: created ?? this.created,
        color: color.present ? color.value : this.color,
        data: data ?? this.data,
      );
  SaveCodeTableData copyWithCompanion(SaveCodeTableCompanion data) {
    return SaveCodeTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      format: data.format.present ? data.format.value : this.format,
      type: data.type.present ? data.type.value : this.type,
      created: data.created.present ? data.created.value : this.created,
      color: data.color.present ? data.color.value : this.color,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaveCodeTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('format: $format, ')
          ..write('type: $type, ')
          ..write('created: $created, ')
          ..write('color: $color, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, format, type, created, color, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaveCodeTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.format == this.format &&
          other.type == this.type &&
          other.created == this.created &&
          other.color == this.color &&
          other.data == this.data);
}

class SaveCodeTableCompanion extends drift.UpdateCompanion<SaveCodeTableData> {
  final drift.Value<int> id;
  final drift.Value<String> title;
  final drift.Value<String> format;
  final drift.Value<String?> type;
  final drift.Value<DateTime> created;
  final drift.Value<int?> color;
  final drift.Value<String> data;
  const SaveCodeTableCompanion({
    this.id = const drift.Value.absent(),
    this.title = const drift.Value.absent(),
    this.format = const drift.Value.absent(),
    this.type = const drift.Value.absent(),
    this.created = const drift.Value.absent(),
    this.color = const drift.Value.absent(),
    this.data = const drift.Value.absent(),
  });
  SaveCodeTableCompanion.insert({
    this.id = const drift.Value.absent(),
    required String title,
    required String format,
    this.type = const drift.Value.absent(),
    required DateTime created,
    this.color = const drift.Value.absent(),
    required String data,
  })  : title = drift.Value(title),
        format = drift.Value(format),
        created = drift.Value(created),
        data = drift.Value(data);
  static drift.Insertable<SaveCodeTableData> custom({
    drift.Expression<int>? id,
    drift.Expression<String>? title,
    drift.Expression<String>? format,
    drift.Expression<String>? type,
    drift.Expression<DateTime>? created,
    drift.Expression<int>? color,
    drift.Expression<String>? data,
  }) {
    return drift.RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (format != null) 'format': format,
      if (type != null) 'type': type,
      if (created != null) 'created': created,
      if (color != null) 'color': color,
      if (data != null) 'data': data,
    });
  }

  SaveCodeTableCompanion copyWith(
      {drift.Value<int>? id,
      drift.Value<String>? title,
      drift.Value<String>? format,
      drift.Value<String?>? type,
      drift.Value<DateTime>? created,
      drift.Value<int?>? color,
      drift.Value<String>? data}) {
    return SaveCodeTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      format: format ?? this.format,
      type: type ?? this.type,
      created: created ?? this.created,
      color: color ?? this.color,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    if (id.present) {
      map['id'] = drift.Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = drift.Variable<String>(title.value);
    }
    if (format.present) {
      map['format'] = drift.Variable<String>(format.value);
    }
    if (type.present) {
      map['type'] = drift.Variable<String>(type.value);
    }
    if (created.present) {
      map['created'] = drift.Variable<DateTime>(created.value);
    }
    if (color.present) {
      map['color'] = drift.Variable<int>(color.value);
    }
    if (data.present) {
      map['data'] = drift.Variable<String>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaveCodeTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('format: $format, ')
          ..write('type: $type, ')
          ..write('created: $created, ')
          ..write('color: $color, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $HistoryCodeTableTable extends HistoryCodeTable
    with drift.TableInfo<$HistoryCodeTableTable, HistoryCodeTableData> {
  @override
  final drift.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryCodeTableTable(this.attachedDatabase, [this._alias]);
  static const drift.VerificationMeta _idMeta =
      const drift.VerificationMeta('id');
  @override
  late final drift.GeneratedColumn<int> id = drift.GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const drift.VerificationMeta _dataMeta =
      const drift.VerificationMeta('data');
  @override
  late final drift.GeneratedColumn<String> data = drift.GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const drift.VerificationMeta _formatMeta =
      const drift.VerificationMeta('format');
  @override
  late final drift.GeneratedColumn<String> format =
      drift.GeneratedColumn<String>('format', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const drift.VerificationMeta _createdMeta =
      const drift.VerificationMeta('created');
  @override
  late final drift.GeneratedColumn<DateTime> created =
      drift.GeneratedColumn<DateTime>('created', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<drift.GeneratedColumn> get $columns => [id, data, format, created];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_code_table';
  @override
  drift.VerificationContext validateIntegrity(
      drift.Insertable<HistoryCodeTableData> instance,
      {bool isInserting = false}) {
    final context = drift.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    return context;
  }

  @override
  Set<drift.GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryCodeTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryCodeTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
    );
  }

  @override
  $HistoryCodeTableTable createAlias(String alias) {
    return $HistoryCodeTableTable(attachedDatabase, alias);
  }
}

class HistoryCodeTableData extends drift.DataClass
    implements drift.Insertable<HistoryCodeTableData> {
  final int id;
  final String data;
  final String format;
  final DateTime created;
  const HistoryCodeTableData(
      {required this.id,
      required this.data,
      required this.format,
      required this.created});
  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    map['id'] = drift.Variable<int>(id);
    map['data'] = drift.Variable<String>(data);
    map['format'] = drift.Variable<String>(format);
    map['created'] = drift.Variable<DateTime>(created);
    return map;
  }

  HistoryCodeTableCompanion toCompanion(bool nullToAbsent) {
    return HistoryCodeTableCompanion(
      id: drift.Value(id),
      data: drift.Value(data),
      format: drift.Value(format),
      created: drift.Value(created),
    );
  }

  factory HistoryCodeTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return HistoryCodeTableData(
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<String>(json['data']),
      format: serializer.fromJson<String>(json['format']),
      created: serializer.fromJson<DateTime>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<String>(data),
      'format': serializer.toJson<String>(format),
      'created': serializer.toJson<DateTime>(created),
    };
  }

  HistoryCodeTableData copyWith(
          {int? id, String? data, String? format, DateTime? created}) =>
      HistoryCodeTableData(
        id: id ?? this.id,
        data: data ?? this.data,
        format: format ?? this.format,
        created: created ?? this.created,
      );
  HistoryCodeTableData copyWithCompanion(HistoryCodeTableCompanion data) {
    return HistoryCodeTableData(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
      format: data.format.present ? data.format.value : this.format,
      created: data.created.present ? data.created.value : this.created,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryCodeTableData(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('format: $format, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, data, format, created);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryCodeTableData &&
          other.id == this.id &&
          other.data == this.data &&
          other.format == this.format &&
          other.created == this.created);
}

class HistoryCodeTableCompanion
    extends drift.UpdateCompanion<HistoryCodeTableData> {
  final drift.Value<int> id;
  final drift.Value<String> data;
  final drift.Value<String> format;
  final drift.Value<DateTime> created;
  const HistoryCodeTableCompanion({
    this.id = const drift.Value.absent(),
    this.data = const drift.Value.absent(),
    this.format = const drift.Value.absent(),
    this.created = const drift.Value.absent(),
  });
  HistoryCodeTableCompanion.insert({
    this.id = const drift.Value.absent(),
    required String data,
    required String format,
    required DateTime created,
  })  : data = drift.Value(data),
        format = drift.Value(format),
        created = drift.Value(created);
  static drift.Insertable<HistoryCodeTableData> custom({
    drift.Expression<int>? id,
    drift.Expression<String>? data,
    drift.Expression<String>? format,
    drift.Expression<DateTime>? created,
  }) {
    return drift.RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (format != null) 'format': format,
      if (created != null) 'created': created,
    });
  }

  HistoryCodeTableCompanion copyWith(
      {drift.Value<int>? id,
      drift.Value<String>? data,
      drift.Value<String>? format,
      drift.Value<DateTime>? created}) {
    return HistoryCodeTableCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
      format: format ?? this.format,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    if (id.present) {
      map['id'] = drift.Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = drift.Variable<String>(data.value);
    }
    if (format.present) {
      map['format'] = drift.Variable<String>(format.value);
    }
    if (created.present) {
      map['created'] = drift.Variable<DateTime>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryCodeTableCompanion(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('format: $format, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

class $CreatedCodeTableTable extends CreatedCodeTable
    with drift.TableInfo<$CreatedCodeTableTable, CreatedCodeTableData> {
  @override
  final drift.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreatedCodeTableTable(this.attachedDatabase, [this._alias]);
  static const drift.VerificationMeta _idMeta =
      const drift.VerificationMeta('id');
  @override
  late final drift.GeneratedColumn<int> id = drift.GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const drift.VerificationMeta _dataMeta =
      const drift.VerificationMeta('data');
  @override
  late final drift.GeneratedColumn<String> data = drift.GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const drift.VerificationMeta _imageMeta =
      const drift.VerificationMeta('image');
  @override
  late final drift.GeneratedColumn<String> image =
      drift.GeneratedColumn<String>('image', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const drift.VerificationMeta _createdMeta =
      const drift.VerificationMeta('created');
  @override
  late final drift.GeneratedColumn<DateTime> created =
      drift.GeneratedColumn<DateTime>('created', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<drift.GeneratedColumn> get $columns => [id, data, image, created];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'created_code_table';
  @override
  drift.VerificationContext validateIntegrity(
      drift.Insertable<CreatedCodeTableData> instance,
      {bool isInserting = false}) {
    final context = drift.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    return context;
  }

  @override
  Set<drift.GeneratedColumn> get $primaryKey => {id};
  @override
  CreatedCodeTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreatedCodeTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
      created: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created'])!,
    );
  }

  @override
  $CreatedCodeTableTable createAlias(String alias) {
    return $CreatedCodeTableTable(attachedDatabase, alias);
  }
}

class CreatedCodeTableData extends drift.DataClass
    implements drift.Insertable<CreatedCodeTableData> {
  final int id;
  final String data;
  final String image;
  final DateTime created;
  const CreatedCodeTableData(
      {required this.id,
      required this.data,
      required this.image,
      required this.created});
  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    map['id'] = drift.Variable<int>(id);
    map['data'] = drift.Variable<String>(data);
    map['image'] = drift.Variable<String>(image);
    map['created'] = drift.Variable<DateTime>(created);
    return map;
  }

  CreatedCodeTableCompanion toCompanion(bool nullToAbsent) {
    return CreatedCodeTableCompanion(
      id: drift.Value(id),
      data: drift.Value(data),
      image: drift.Value(image),
      created: drift.Value(created),
    );
  }

  factory CreatedCodeTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return CreatedCodeTableData(
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<String>(json['data']),
      image: serializer.fromJson<String>(json['image']),
      created: serializer.fromJson<DateTime>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<String>(data),
      'image': serializer.toJson<String>(image),
      'created': serializer.toJson<DateTime>(created),
    };
  }

  CreatedCodeTableData copyWith(
          {int? id, String? data, String? image, DateTime? created}) =>
      CreatedCodeTableData(
        id: id ?? this.id,
        data: data ?? this.data,
        image: image ?? this.image,
        created: created ?? this.created,
      );
  CreatedCodeTableData copyWithCompanion(CreatedCodeTableCompanion data) {
    return CreatedCodeTableData(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
      image: data.image.present ? data.image.value : this.image,
      created: data.created.present ? data.created.value : this.created,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreatedCodeTableData(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('image: $image, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, data, image, created);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreatedCodeTableData &&
          other.id == this.id &&
          other.data == this.data &&
          other.image == this.image &&
          other.created == this.created);
}

class CreatedCodeTableCompanion
    extends drift.UpdateCompanion<CreatedCodeTableData> {
  final drift.Value<int> id;
  final drift.Value<String> data;
  final drift.Value<String> image;
  final drift.Value<DateTime> created;
  const CreatedCodeTableCompanion({
    this.id = const drift.Value.absent(),
    this.data = const drift.Value.absent(),
    this.image = const drift.Value.absent(),
    this.created = const drift.Value.absent(),
  });
  CreatedCodeTableCompanion.insert({
    this.id = const drift.Value.absent(),
    required String data,
    required String image,
    required DateTime created,
  })  : data = drift.Value(data),
        image = drift.Value(image),
        created = drift.Value(created);
  static drift.Insertable<CreatedCodeTableData> custom({
    drift.Expression<int>? id,
    drift.Expression<String>? data,
    drift.Expression<String>? image,
    drift.Expression<DateTime>? created,
  }) {
    return drift.RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (image != null) 'image': image,
      if (created != null) 'created': created,
    });
  }

  CreatedCodeTableCompanion copyWith(
      {drift.Value<int>? id,
      drift.Value<String>? data,
      drift.Value<String>? image,
      drift.Value<DateTime>? created}) {
    return CreatedCodeTableCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
      image: image ?? this.image,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    if (id.present) {
      map['id'] = drift.Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = drift.Variable<String>(data.value);
    }
    if (image.present) {
      map['image'] = drift.Variable<String>(image.value);
    }
    if (created.present) {
      map['created'] = drift.Variable<DateTime>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreatedCodeTableCompanion(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('image: $image, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataBase extends drift.GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  $AppDataBaseManager get managers => $AppDataBaseManager(this);
  late final $SaveCodeTableTable saveCodeTable = $SaveCodeTableTable(this);
  late final $HistoryCodeTableTable historyCodeTable =
      $HistoryCodeTableTable(this);
  late final $CreatedCodeTableTable createdCodeTable =
      $CreatedCodeTableTable(this);
  @override
  Iterable<drift.TableInfo<drift.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<drift.TableInfo<drift.Table, Object?>>();
  @override
  List<drift.DatabaseSchemaEntity> get allSchemaEntities =>
      [saveCodeTable, historyCodeTable, createdCodeTable];
}

typedef $$SaveCodeTableTableCreateCompanionBuilder = SaveCodeTableCompanion
    Function({
  drift.Value<int> id,
  required String title,
  required String format,
  drift.Value<String?> type,
  required DateTime created,
  drift.Value<int?> color,
  required String data,
});
typedef $$SaveCodeTableTableUpdateCompanionBuilder = SaveCodeTableCompanion
    Function({
  drift.Value<int> id,
  drift.Value<String> title,
  drift.Value<String> format,
  drift.Value<String?> type,
  drift.Value<DateTime> created,
  drift.Value<int?> color,
  drift.Value<String> data,
});

class $$SaveCodeTableTableFilterComposer
    extends drift.Composer<_$AppDataBase, $SaveCodeTableTable> {
  $$SaveCodeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => drift.ColumnFilters(column));
}

class $$SaveCodeTableTableOrderingComposer
    extends drift.Composer<_$AppDataBase, $SaveCodeTableTable> {
  $$SaveCodeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<String> get format => $composableBuilder(
      column: $table.format,
      builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<DateTime> get created => $composableBuilder(
      column: $table.created,
      builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => drift.ColumnOrderings(column));
}

class $$SaveCodeTableTableAnnotationComposer
    extends drift.Composer<_$AppDataBase, $SaveCodeTableTable> {
  $$SaveCodeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  drift.GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  drift.GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  drift.GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  drift.GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  drift.GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  drift.GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$SaveCodeTableTableTableManager extends drift.RootTableManager<
    _$AppDataBase,
    $SaveCodeTableTable,
    SaveCodeTableData,
    $$SaveCodeTableTableFilterComposer,
    $$SaveCodeTableTableOrderingComposer,
    $$SaveCodeTableTableAnnotationComposer,
    $$SaveCodeTableTableCreateCompanionBuilder,
    $$SaveCodeTableTableUpdateCompanionBuilder,
    (
      SaveCodeTableData,
      drift
      .BaseReferences<_$AppDataBase, $SaveCodeTableTable, SaveCodeTableData>
    ),
    SaveCodeTableData,
    drift.PrefetchHooks Function()> {
  $$SaveCodeTableTableTableManager(_$AppDataBase db, $SaveCodeTableTable table)
      : super(drift.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaveCodeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaveCodeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaveCodeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            drift.Value<int> id = const drift.Value.absent(),
            drift.Value<String> title = const drift.Value.absent(),
            drift.Value<String> format = const drift.Value.absent(),
            drift.Value<String?> type = const drift.Value.absent(),
            drift.Value<DateTime> created = const drift.Value.absent(),
            drift.Value<int?> color = const drift.Value.absent(),
            drift.Value<String> data = const drift.Value.absent(),
          }) =>
              SaveCodeTableCompanion(
            id: id,
            title: title,
            format: format,
            type: type,
            created: created,
            color: color,
            data: data,
          ),
          createCompanionCallback: ({
            drift.Value<int> id = const drift.Value.absent(),
            required String title,
            required String format,
            drift.Value<String?> type = const drift.Value.absent(),
            required DateTime created,
            drift.Value<int?> color = const drift.Value.absent(),
            required String data,
          }) =>
              SaveCodeTableCompanion.insert(
            id: id,
            title: title,
            format: format,
            type: type,
            created: created,
            color: color,
            data: data,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), drift.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SaveCodeTableTableProcessedTableManager = drift.ProcessedTableManager<
    _$AppDataBase,
    $SaveCodeTableTable,
    SaveCodeTableData,
    $$SaveCodeTableTableFilterComposer,
    $$SaveCodeTableTableOrderingComposer,
    $$SaveCodeTableTableAnnotationComposer,
    $$SaveCodeTableTableCreateCompanionBuilder,
    $$SaveCodeTableTableUpdateCompanionBuilder,
    (
      SaveCodeTableData,
      drift
      .BaseReferences<_$AppDataBase, $SaveCodeTableTable, SaveCodeTableData>
    ),
    SaveCodeTableData,
    drift.PrefetchHooks Function()>;
typedef $$HistoryCodeTableTableCreateCompanionBuilder
    = HistoryCodeTableCompanion Function({
  drift.Value<int> id,
  required String data,
  required String format,
  required DateTime created,
});
typedef $$HistoryCodeTableTableUpdateCompanionBuilder
    = HistoryCodeTableCompanion Function({
  drift.Value<int> id,
  drift.Value<String> data,
  drift.Value<String> format,
  drift.Value<DateTime> created,
});

class $$HistoryCodeTableTableFilterComposer
    extends drift.Composer<_$AppDataBase, $HistoryCodeTableTable> {
  $$HistoryCodeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => drift.ColumnFilters(column));
}

class $$HistoryCodeTableTableOrderingComposer
    extends drift.Composer<_$AppDataBase, $HistoryCodeTableTable> {
  $$HistoryCodeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<String> get format => $composableBuilder(
      column: $table.format,
      builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<DateTime> get created => $composableBuilder(
      column: $table.created,
      builder: (column) => drift.ColumnOrderings(column));
}

class $$HistoryCodeTableTableAnnotationComposer
    extends drift.Composer<_$AppDataBase, $HistoryCodeTableTable> {
  $$HistoryCodeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  drift.GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  drift.GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  drift.GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);
}

class $$HistoryCodeTableTableTableManager extends drift.RootTableManager<
    _$AppDataBase,
    $HistoryCodeTableTable,
    HistoryCodeTableData,
    $$HistoryCodeTableTableFilterComposer,
    $$HistoryCodeTableTableOrderingComposer,
    $$HistoryCodeTableTableAnnotationComposer,
    $$HistoryCodeTableTableCreateCompanionBuilder,
    $$HistoryCodeTableTableUpdateCompanionBuilder,
    (
      HistoryCodeTableData,
      drift.BaseReferences<_$AppDataBase, $HistoryCodeTableTable,
          HistoryCodeTableData>
    ),
    HistoryCodeTableData,
    drift.PrefetchHooks Function()> {
  $$HistoryCodeTableTableTableManager(
      _$AppDataBase db, $HistoryCodeTableTable table)
      : super(drift.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoryCodeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoryCodeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoryCodeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            drift.Value<int> id = const drift.Value.absent(),
            drift.Value<String> data = const drift.Value.absent(),
            drift.Value<String> format = const drift.Value.absent(),
            drift.Value<DateTime> created = const drift.Value.absent(),
          }) =>
              HistoryCodeTableCompanion(
            id: id,
            data: data,
            format: format,
            created: created,
          ),
          createCompanionCallback: ({
            drift.Value<int> id = const drift.Value.absent(),
            required String data,
            required String format,
            required DateTime created,
          }) =>
              HistoryCodeTableCompanion.insert(
            id: id,
            data: data,
            format: format,
            created: created,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), drift.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HistoryCodeTableTableProcessedTableManager
    = drift.ProcessedTableManager<
        _$AppDataBase,
        $HistoryCodeTableTable,
        HistoryCodeTableData,
        $$HistoryCodeTableTableFilterComposer,
        $$HistoryCodeTableTableOrderingComposer,
        $$HistoryCodeTableTableAnnotationComposer,
        $$HistoryCodeTableTableCreateCompanionBuilder,
        $$HistoryCodeTableTableUpdateCompanionBuilder,
        (
          HistoryCodeTableData,
          drift.BaseReferences<_$AppDataBase, $HistoryCodeTableTable,
              HistoryCodeTableData>
        ),
        HistoryCodeTableData,
        drift.PrefetchHooks Function()>;
typedef $$CreatedCodeTableTableCreateCompanionBuilder
    = CreatedCodeTableCompanion Function({
  drift.Value<int> id,
  required String data,
  required String image,
  required DateTime created,
});
typedef $$CreatedCodeTableTableUpdateCompanionBuilder
    = CreatedCodeTableCompanion Function({
  drift.Value<int> id,
  drift.Value<String> data,
  drift.Value<String> image,
  drift.Value<DateTime> created,
});

class $$CreatedCodeTableTableFilterComposer
    extends drift.Composer<_$AppDataBase, $CreatedCodeTableTable> {
  $$CreatedCodeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => drift.ColumnFilters(column));

  drift.ColumnFilters<DateTime> get created => $composableBuilder(
      column: $table.created, builder: (column) => drift.ColumnFilters(column));
}

class $$CreatedCodeTableTableOrderingComposer
    extends drift.Composer<_$AppDataBase, $CreatedCodeTableTable> {
  $$CreatedCodeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => drift.ColumnOrderings(column));

  drift.ColumnOrderings<DateTime> get created => $composableBuilder(
      column: $table.created,
      builder: (column) => drift.ColumnOrderings(column));
}

class $$CreatedCodeTableTableAnnotationComposer
    extends drift.Composer<_$AppDataBase, $CreatedCodeTableTable> {
  $$CreatedCodeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  drift.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  drift.GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  drift.GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  drift.GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);
}

class $$CreatedCodeTableTableTableManager extends drift.RootTableManager<
    _$AppDataBase,
    $CreatedCodeTableTable,
    CreatedCodeTableData,
    $$CreatedCodeTableTableFilterComposer,
    $$CreatedCodeTableTableOrderingComposer,
    $$CreatedCodeTableTableAnnotationComposer,
    $$CreatedCodeTableTableCreateCompanionBuilder,
    $$CreatedCodeTableTableUpdateCompanionBuilder,
    (
      CreatedCodeTableData,
      drift.BaseReferences<_$AppDataBase, $CreatedCodeTableTable,
          CreatedCodeTableData>
    ),
    CreatedCodeTableData,
    drift.PrefetchHooks Function()> {
  $$CreatedCodeTableTableTableManager(
      _$AppDataBase db, $CreatedCodeTableTable table)
      : super(drift.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreatedCodeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreatedCodeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreatedCodeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            drift.Value<int> id = const drift.Value.absent(),
            drift.Value<String> data = const drift.Value.absent(),
            drift.Value<String> image = const drift.Value.absent(),
            drift.Value<DateTime> created = const drift.Value.absent(),
          }) =>
              CreatedCodeTableCompanion(
            id: id,
            data: data,
            image: image,
            created: created,
          ),
          createCompanionCallback: ({
            drift.Value<int> id = const drift.Value.absent(),
            required String data,
            required String image,
            required DateTime created,
          }) =>
              CreatedCodeTableCompanion.insert(
            id: id,
            data: data,
            image: image,
            created: created,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), drift.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CreatedCodeTableTableProcessedTableManager
    = drift.ProcessedTableManager<
        _$AppDataBase,
        $CreatedCodeTableTable,
        CreatedCodeTableData,
        $$CreatedCodeTableTableFilterComposer,
        $$CreatedCodeTableTableOrderingComposer,
        $$CreatedCodeTableTableAnnotationComposer,
        $$CreatedCodeTableTableCreateCompanionBuilder,
        $$CreatedCodeTableTableUpdateCompanionBuilder,
        (
          CreatedCodeTableData,
          drift.BaseReferences<_$AppDataBase, $CreatedCodeTableTable,
              CreatedCodeTableData>
        ),
        CreatedCodeTableData,
        drift.PrefetchHooks Function()>;

class $AppDataBaseManager {
  final _$AppDataBase _db;
  $AppDataBaseManager(this._db);
  $$SaveCodeTableTableTableManager get saveCodeTable =>
      $$SaveCodeTableTableTableManager(_db, _db.saveCodeTable);
  $$HistoryCodeTableTableTableManager get historyCodeTable =>
      $$HistoryCodeTableTableTableManager(_db, _db.historyCodeTable);
  $$CreatedCodeTableTableTableManager get createdCodeTable =>
      $$CreatedCodeTableTableTableManager(_db, _db.createdCodeTable);
}
