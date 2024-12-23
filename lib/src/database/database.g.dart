// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TLPItemsTable extends TLPItems with TableInfo<$TLPItemsTable, TLPItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TLPItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fingerprintMeta =
      const VerificationMeta('fingerprint');
  @override
  late final GeneratedColumn<String> fingerprint = GeneratedColumn<String>(
      'fingerprint', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _answerEncMeta =
      const VerificationMeta('answerEnc');
  @override
  late final GeneratedColumn<String> answerEnc = GeneratedColumn<String>(
      'answer_enc', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, fingerprint, answerEnc, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_l_p_items';
  @override
  VerificationContext validateIntegrity(Insertable<TLPItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fingerprint')) {
      context.handle(
          _fingerprintMeta,
          fingerprint.isAcceptableOrUnknown(
              data['fingerprint']!, _fingerprintMeta));
    } else if (isInserting) {
      context.missing(_fingerprintMeta);
    }
    if (data.containsKey('answer_enc')) {
      context.handle(_answerEncMeta,
          answerEnc.isAcceptableOrUnknown(data['answer_enc']!, _answerEncMeta));
    } else if (isInserting) {
      context.missing(_answerEncMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TLPItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TLPItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fingerprint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fingerprint'])!,
      answerEnc: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answer_enc'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $TLPItemsTable createAlias(String alias) {
    return $TLPItemsTable(attachedDatabase, alias);
  }
}

class TLPItem extends DataClass implements Insertable<TLPItem> {
  final int id;
  final String fingerprint;
  final String answerEnc;
  final DateTime? createdAt;
  const TLPItem(
      {required this.id,
      required this.fingerprint,
      required this.answerEnc,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fingerprint'] = Variable<String>(fingerprint);
    map['answer_enc'] = Variable<String>(answerEnc);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  TLPItemsCompanion toCompanion(bool nullToAbsent) {
    return TLPItemsCompanion(
      id: Value(id),
      fingerprint: Value(fingerprint),
      answerEnc: Value(answerEnc),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory TLPItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TLPItem(
      id: serializer.fromJson<int>(json['id']),
      fingerprint: serializer.fromJson<String>(json['fingerprint']),
      answerEnc: serializer.fromJson<String>(json['answerEnc']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fingerprint': serializer.toJson<String>(fingerprint),
      'answerEnc': serializer.toJson<String>(answerEnc),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  TLPItem copyWith(
          {int? id,
          String? fingerprint,
          String? answerEnc,
          Value<DateTime?> createdAt = const Value.absent()}) =>
      TLPItem(
        id: id ?? this.id,
        fingerprint: fingerprint ?? this.fingerprint,
        answerEnc: answerEnc ?? this.answerEnc,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  TLPItem copyWithCompanion(TLPItemsCompanion data) {
    return TLPItem(
      id: data.id.present ? data.id.value : this.id,
      fingerprint:
          data.fingerprint.present ? data.fingerprint.value : this.fingerprint,
      answerEnc: data.answerEnc.present ? data.answerEnc.value : this.answerEnc,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TLPItem(')
          ..write('id: $id, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('answerEnc: $answerEnc, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fingerprint, answerEnc, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TLPItem &&
          other.id == this.id &&
          other.fingerprint == this.fingerprint &&
          other.answerEnc == this.answerEnc &&
          other.createdAt == this.createdAt);
}

class TLPItemsCompanion extends UpdateCompanion<TLPItem> {
  final Value<int> id;
  final Value<String> fingerprint;
  final Value<String> answerEnc;
  final Value<DateTime?> createdAt;
  const TLPItemsCompanion({
    this.id = const Value.absent(),
    this.fingerprint = const Value.absent(),
    this.answerEnc = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TLPItemsCompanion.insert({
    this.id = const Value.absent(),
    required String fingerprint,
    required String answerEnc,
    this.createdAt = const Value.absent(),
  })  : fingerprint = Value(fingerprint),
        answerEnc = Value(answerEnc);
  static Insertable<TLPItem> custom({
    Expression<int>? id,
    Expression<String>? fingerprint,
    Expression<String>? answerEnc,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fingerprint != null) 'fingerprint': fingerprint,
      if (answerEnc != null) 'answer_enc': answerEnc,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TLPItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? fingerprint,
      Value<String>? answerEnc,
      Value<DateTime?>? createdAt}) {
    return TLPItemsCompanion(
      id: id ?? this.id,
      fingerprint: fingerprint ?? this.fingerprint,
      answerEnc: answerEnc ?? this.answerEnc,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fingerprint.present) {
      map['fingerprint'] = Variable<String>(fingerprint.value);
    }
    if (answerEnc.present) {
      map['answer_enc'] = Variable<String>(answerEnc.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TLPItemsCompanion(')
          ..write('id: $id, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('answerEnc: $answerEnc, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TLPItemsTable tLPItems = $TLPItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tLPItems];
}

typedef $$TLPItemsTableCreateCompanionBuilder = TLPItemsCompanion Function({
  Value<int> id,
  required String fingerprint,
  required String answerEnc,
  Value<DateTime?> createdAt,
});
typedef $$TLPItemsTableUpdateCompanionBuilder = TLPItemsCompanion Function({
  Value<int> id,
  Value<String> fingerprint,
  Value<String> answerEnc,
  Value<DateTime?> createdAt,
});

class $$TLPItemsTableFilterComposer
    extends Composer<_$AppDatabase, $TLPItemsTable> {
  $$TLPItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fingerprint => $composableBuilder(
      column: $table.fingerprint, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answerEnc => $composableBuilder(
      column: $table.answerEnc, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$TLPItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $TLPItemsTable> {
  $$TLPItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fingerprint => $composableBuilder(
      column: $table.fingerprint, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answerEnc => $composableBuilder(
      column: $table.answerEnc, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TLPItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TLPItemsTable> {
  $$TLPItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fingerprint => $composableBuilder(
      column: $table.fingerprint, builder: (column) => column);

  GeneratedColumn<String> get answerEnc =>
      $composableBuilder(column: $table.answerEnc, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TLPItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TLPItemsTable,
    TLPItem,
    $$TLPItemsTableFilterComposer,
    $$TLPItemsTableOrderingComposer,
    $$TLPItemsTableAnnotationComposer,
    $$TLPItemsTableCreateCompanionBuilder,
    $$TLPItemsTableUpdateCompanionBuilder,
    (TLPItem, BaseReferences<_$AppDatabase, $TLPItemsTable, TLPItem>),
    TLPItem,
    PrefetchHooks Function()> {
  $$TLPItemsTableTableManager(_$AppDatabase db, $TLPItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TLPItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TLPItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TLPItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> fingerprint = const Value.absent(),
            Value<String> answerEnc = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              TLPItemsCompanion(
            id: id,
            fingerprint: fingerprint,
            answerEnc: answerEnc,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String fingerprint,
            required String answerEnc,
            Value<DateTime?> createdAt = const Value.absent(),
          }) =>
              TLPItemsCompanion.insert(
            id: id,
            fingerprint: fingerprint,
            answerEnc: answerEnc,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TLPItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TLPItemsTable,
    TLPItem,
    $$TLPItemsTableFilterComposer,
    $$TLPItemsTableOrderingComposer,
    $$TLPItemsTableAnnotationComposer,
    $$TLPItemsTableCreateCompanionBuilder,
    $$TLPItemsTableUpdateCompanionBuilder,
    (TLPItem, BaseReferences<_$AppDatabase, $TLPItemsTable, TLPItem>),
    TLPItem,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TLPItemsTableTableManager get tLPItems =>
      $$TLPItemsTableTableManager(_db, _db.tLPItems);
}
