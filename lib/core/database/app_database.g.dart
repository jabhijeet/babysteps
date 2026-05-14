// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BabiesTable extends Babies with TableInfo<$BabiesTable, Baby> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BabiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _encryptedNameMeta = const VerificationMeta(
    'encryptedName',
  );
  @override
  late final GeneratedColumn<String> encryptedName = GeneratedColumn<String>(
    'encrypted_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _encryptedDateOfBirthMeta =
      const VerificationMeta('encryptedDateOfBirth');
  @override
  late final GeneratedColumn<String> encryptedDateOfBirth =
      GeneratedColumn<String>(
        'encrypted_date_of_birth',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _encryptedGenderMeta = const VerificationMeta(
    'encryptedGender',
  );
  @override
  late final GeneratedColumn<String> encryptedGender = GeneratedColumn<String>(
    'encrypted_gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteFolderIdMeta = const VerificationMeta(
    'remoteFolderId',
  );
  @override
  late final GeneratedColumn<String> remoteFolderId = GeneratedColumn<String>(
    'remote_folder_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    encryptedName,
    encryptedDateOfBirth,
    encryptedGender,
    remoteFolderId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'babies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Baby> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('encrypted_name')) {
      context.handle(
        _encryptedNameMeta,
        encryptedName.isAcceptableOrUnknown(
          data['encrypted_name']!,
          _encryptedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_encryptedNameMeta);
    }
    if (data.containsKey('encrypted_date_of_birth')) {
      context.handle(
        _encryptedDateOfBirthMeta,
        encryptedDateOfBirth.isAcceptableOrUnknown(
          data['encrypted_date_of_birth']!,
          _encryptedDateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_encryptedDateOfBirthMeta);
    }
    if (data.containsKey('encrypted_gender')) {
      context.handle(
        _encryptedGenderMeta,
        encryptedGender.isAcceptableOrUnknown(
          data['encrypted_gender']!,
          _encryptedGenderMeta,
        ),
      );
    }
    if (data.containsKey('remote_folder_id')) {
      context.handle(
        _remoteFolderIdMeta,
        remoteFolderId.isAcceptableOrUnknown(
          data['remote_folder_id']!,
          _remoteFolderIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Baby map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Baby(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      encryptedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}encrypted_name'],
      )!,
      encryptedDateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}encrypted_date_of_birth'],
      )!,
      encryptedGender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}encrypted_gender'],
      ),
      remoteFolderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_folder_id'],
      ),
    );
  }

  @override
  $BabiesTable createAlias(String alias) {
    return $BabiesTable(attachedDatabase, alias);
  }
}

class Baby extends DataClass implements Insertable<Baby> {
  final int id;
  final String encryptedName;
  final String encryptedDateOfBirth;
  final String? encryptedGender;
  final String? remoteFolderId;
  const Baby({
    required this.id,
    required this.encryptedName,
    required this.encryptedDateOfBirth,
    this.encryptedGender,
    this.remoteFolderId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['encrypted_name'] = Variable<String>(encryptedName);
    map['encrypted_date_of_birth'] = Variable<String>(encryptedDateOfBirth);
    if (!nullToAbsent || encryptedGender != null) {
      map['encrypted_gender'] = Variable<String>(encryptedGender);
    }
    if (!nullToAbsent || remoteFolderId != null) {
      map['remote_folder_id'] = Variable<String>(remoteFolderId);
    }
    return map;
  }

  BabiesCompanion toCompanion(bool nullToAbsent) {
    return BabiesCompanion(
      id: Value(id),
      encryptedName: Value(encryptedName),
      encryptedDateOfBirth: Value(encryptedDateOfBirth),
      encryptedGender: encryptedGender == null && nullToAbsent
          ? const Value.absent()
          : Value(encryptedGender),
      remoteFolderId: remoteFolderId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteFolderId),
    );
  }

  factory Baby.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Baby(
      id: serializer.fromJson<int>(json['id']),
      encryptedName: serializer.fromJson<String>(json['encryptedName']),
      encryptedDateOfBirth: serializer.fromJson<String>(
        json['encryptedDateOfBirth'],
      ),
      encryptedGender: serializer.fromJson<String?>(json['encryptedGender']),
      remoteFolderId: serializer.fromJson<String?>(json['remoteFolderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'encryptedName': serializer.toJson<String>(encryptedName),
      'encryptedDateOfBirth': serializer.toJson<String>(encryptedDateOfBirth),
      'encryptedGender': serializer.toJson<String?>(encryptedGender),
      'remoteFolderId': serializer.toJson<String?>(remoteFolderId),
    };
  }

  Baby copyWith({
    int? id,
    String? encryptedName,
    String? encryptedDateOfBirth,
    Value<String?> encryptedGender = const Value.absent(),
    Value<String?> remoteFolderId = const Value.absent(),
  }) => Baby(
    id: id ?? this.id,
    encryptedName: encryptedName ?? this.encryptedName,
    encryptedDateOfBirth: encryptedDateOfBirth ?? this.encryptedDateOfBirth,
    encryptedGender: encryptedGender.present
        ? encryptedGender.value
        : this.encryptedGender,
    remoteFolderId: remoteFolderId.present
        ? remoteFolderId.value
        : this.remoteFolderId,
  );
  Baby copyWithCompanion(BabiesCompanion data) {
    return Baby(
      id: data.id.present ? data.id.value : this.id,
      encryptedName: data.encryptedName.present
          ? data.encryptedName.value
          : this.encryptedName,
      encryptedDateOfBirth: data.encryptedDateOfBirth.present
          ? data.encryptedDateOfBirth.value
          : this.encryptedDateOfBirth,
      encryptedGender: data.encryptedGender.present
          ? data.encryptedGender.value
          : this.encryptedGender,
      remoteFolderId: data.remoteFolderId.present
          ? data.remoteFolderId.value
          : this.remoteFolderId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Baby(')
          ..write('id: $id, ')
          ..write('encryptedName: $encryptedName, ')
          ..write('encryptedDateOfBirth: $encryptedDateOfBirth, ')
          ..write('encryptedGender: $encryptedGender, ')
          ..write('remoteFolderId: $remoteFolderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    encryptedName,
    encryptedDateOfBirth,
    encryptedGender,
    remoteFolderId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Baby &&
          other.id == this.id &&
          other.encryptedName == this.encryptedName &&
          other.encryptedDateOfBirth == this.encryptedDateOfBirth &&
          other.encryptedGender == this.encryptedGender &&
          other.remoteFolderId == this.remoteFolderId);
}

class BabiesCompanion extends UpdateCompanion<Baby> {
  final Value<int> id;
  final Value<String> encryptedName;
  final Value<String> encryptedDateOfBirth;
  final Value<String?> encryptedGender;
  final Value<String?> remoteFolderId;
  const BabiesCompanion({
    this.id = const Value.absent(),
    this.encryptedName = const Value.absent(),
    this.encryptedDateOfBirth = const Value.absent(),
    this.encryptedGender = const Value.absent(),
    this.remoteFolderId = const Value.absent(),
  });
  BabiesCompanion.insert({
    this.id = const Value.absent(),
    required String encryptedName,
    required String encryptedDateOfBirth,
    this.encryptedGender = const Value.absent(),
    this.remoteFolderId = const Value.absent(),
  }) : encryptedName = Value(encryptedName),
       encryptedDateOfBirth = Value(encryptedDateOfBirth);
  static Insertable<Baby> custom({
    Expression<int>? id,
    Expression<String>? encryptedName,
    Expression<String>? encryptedDateOfBirth,
    Expression<String>? encryptedGender,
    Expression<String>? remoteFolderId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (encryptedName != null) 'encrypted_name': encryptedName,
      if (encryptedDateOfBirth != null)
        'encrypted_date_of_birth': encryptedDateOfBirth,
      if (encryptedGender != null) 'encrypted_gender': encryptedGender,
      if (remoteFolderId != null) 'remote_folder_id': remoteFolderId,
    });
  }

  BabiesCompanion copyWith({
    Value<int>? id,
    Value<String>? encryptedName,
    Value<String>? encryptedDateOfBirth,
    Value<String?>? encryptedGender,
    Value<String?>? remoteFolderId,
  }) {
    return BabiesCompanion(
      id: id ?? this.id,
      encryptedName: encryptedName ?? this.encryptedName,
      encryptedDateOfBirth: encryptedDateOfBirth ?? this.encryptedDateOfBirth,
      encryptedGender: encryptedGender ?? this.encryptedGender,
      remoteFolderId: remoteFolderId ?? this.remoteFolderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (encryptedName.present) {
      map['encrypted_name'] = Variable<String>(encryptedName.value);
    }
    if (encryptedDateOfBirth.present) {
      map['encrypted_date_of_birth'] = Variable<String>(
        encryptedDateOfBirth.value,
      );
    }
    if (encryptedGender.present) {
      map['encrypted_gender'] = Variable<String>(encryptedGender.value);
    }
    if (remoteFolderId.present) {
      map['remote_folder_id'] = Variable<String>(remoteFolderId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BabiesCompanion(')
          ..write('id: $id, ')
          ..write('encryptedName: $encryptedName, ')
          ..write('encryptedDateOfBirth: $encryptedDateOfBirth, ')
          ..write('encryptedGender: $encryptedGender, ')
          ..write('remoteFolderId: $remoteFolderId')
          ..write(')'))
        .toString();
  }
}

class $FeedingLogsTable extends FeedingLogs
    with TableInfo<$FeedingLogsTable, FeedingLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedingLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _babyIdMeta = const VerificationMeta('babyId');
  @override
  late final GeneratedColumn<int> babyId = GeneratedColumn<int>(
    'baby_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES babies (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _volumeAmountMeta = const VerificationMeta(
    'volumeAmount',
  );
  @override
  late final GeneratedColumn<double> volumeAmount = GeneratedColumn<double>(
    'volume_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _volumeUnitMeta = const VerificationMeta(
    'volumeUnit',
  );
  @override
  late final GeneratedColumn<String> volumeUnit = GeneratedColumn<String>(
    'volume_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _breastSideMeta = const VerificationMeta(
    'breastSide',
  );
  @override
  late final GeneratedColumn<String> breastSide = GeneratedColumn<String>(
    'breast_side',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leftDurationSecondsMeta =
      const VerificationMeta('leftDurationSeconds');
  @override
  late final GeneratedColumn<int> leftDurationSeconds = GeneratedColumn<int>(
    'left_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rightDurationSecondsMeta =
      const VerificationMeta('rightDurationSeconds');
  @override
  late final GeneratedColumn<int> rightDurationSeconds = GeneratedColumn<int>(
    'right_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formulaBrandMeta = const VerificationMeta(
    'formulaBrand',
  );
  @override
  late final GeneratedColumn<String> formulaBrand = GeneratedColumn<String>(
    'formula_brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formulaTempMeta = const VerificationMeta(
    'formulaTemp',
  );
  @override
  late final GeneratedColumn<double> formulaTemp = GeneratedColumn<double>(
    'formula_temp',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _solidFoodReactionMeta = const VerificationMeta(
    'solidFoodReaction',
  );
  @override
  late final GeneratedColumn<String> solidFoodReaction =
      GeneratedColumn<String>(
        'solid_food_reaction',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _solidFoodReactionPhotoPathMeta =
      const VerificationMeta('solidFoodReactionPhotoPath');
  @override
  late final GeneratedColumn<String> solidFoodReactionPhotoPath =
      GeneratedColumn<String>(
        'solid_food_reaction_photo_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    babyId,
    type,
    startTime,
    endTime,
    volumeAmount,
    volumeUnit,
    breastSide,
    leftDurationSeconds,
    rightDurationSeconds,
    formulaBrand,
    formulaTemp,
    solidFoodReaction,
    solidFoodReactionPhotoPath,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeding_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedingLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('baby_id')) {
      context.handle(
        _babyIdMeta,
        babyId.isAcceptableOrUnknown(data['baby_id']!, _babyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_babyIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('volume_amount')) {
      context.handle(
        _volumeAmountMeta,
        volumeAmount.isAcceptableOrUnknown(
          data['volume_amount']!,
          _volumeAmountMeta,
        ),
      );
    }
    if (data.containsKey('volume_unit')) {
      context.handle(
        _volumeUnitMeta,
        volumeUnit.isAcceptableOrUnknown(data['volume_unit']!, _volumeUnitMeta),
      );
    }
    if (data.containsKey('breast_side')) {
      context.handle(
        _breastSideMeta,
        breastSide.isAcceptableOrUnknown(data['breast_side']!, _breastSideMeta),
      );
    }
    if (data.containsKey('left_duration_seconds')) {
      context.handle(
        _leftDurationSecondsMeta,
        leftDurationSeconds.isAcceptableOrUnknown(
          data['left_duration_seconds']!,
          _leftDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('right_duration_seconds')) {
      context.handle(
        _rightDurationSecondsMeta,
        rightDurationSeconds.isAcceptableOrUnknown(
          data['right_duration_seconds']!,
          _rightDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('formula_brand')) {
      context.handle(
        _formulaBrandMeta,
        formulaBrand.isAcceptableOrUnknown(
          data['formula_brand']!,
          _formulaBrandMeta,
        ),
      );
    }
    if (data.containsKey('formula_temp')) {
      context.handle(
        _formulaTempMeta,
        formulaTemp.isAcceptableOrUnknown(
          data['formula_temp']!,
          _formulaTempMeta,
        ),
      );
    }
    if (data.containsKey('solid_food_reaction')) {
      context.handle(
        _solidFoodReactionMeta,
        solidFoodReaction.isAcceptableOrUnknown(
          data['solid_food_reaction']!,
          _solidFoodReactionMeta,
        ),
      );
    }
    if (data.containsKey('solid_food_reaction_photo_path')) {
      context.handle(
        _solidFoodReactionPhotoPathMeta,
        solidFoodReactionPhotoPath.isAcceptableOrUnknown(
          data['solid_food_reaction_photo_path']!,
          _solidFoodReactionPhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedingLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedingLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      babyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baby_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      volumeAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_amount'],
      ),
      volumeUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}volume_unit'],
      ),
      breastSide: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breast_side'],
      ),
      leftDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}left_duration_seconds'],
      ),
      rightDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}right_duration_seconds'],
      ),
      formulaBrand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formula_brand'],
      ),
      formulaTemp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}formula_temp'],
      ),
      solidFoodReaction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solid_food_reaction'],
      ),
      solidFoodReactionPhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solid_food_reaction_photo_path'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $FeedingLogsTable createAlias(String alias) {
    return $FeedingLogsTable(attachedDatabase, alias);
  }
}

class FeedingLog extends DataClass implements Insertable<FeedingLog> {
  final int id;
  final int babyId;
  final String type;
  final DateTime startTime;
  final DateTime? endTime;
  final double? volumeAmount;
  final String? volumeUnit;
  final String? breastSide;
  final int? leftDurationSeconds;
  final int? rightDurationSeconds;
  final String? formulaBrand;
  final double? formulaTemp;
  final String? solidFoodReaction;
  final String? solidFoodReactionPhotoPath;
  final String? notes;
  const FeedingLog({
    required this.id,
    required this.babyId,
    required this.type,
    required this.startTime,
    this.endTime,
    this.volumeAmount,
    this.volumeUnit,
    this.breastSide,
    this.leftDurationSeconds,
    this.rightDurationSeconds,
    this.formulaBrand,
    this.formulaTemp,
    this.solidFoodReaction,
    this.solidFoodReactionPhotoPath,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['baby_id'] = Variable<int>(babyId);
    map['type'] = Variable<String>(type);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || volumeAmount != null) {
      map['volume_amount'] = Variable<double>(volumeAmount);
    }
    if (!nullToAbsent || volumeUnit != null) {
      map['volume_unit'] = Variable<String>(volumeUnit);
    }
    if (!nullToAbsent || breastSide != null) {
      map['breast_side'] = Variable<String>(breastSide);
    }
    if (!nullToAbsent || leftDurationSeconds != null) {
      map['left_duration_seconds'] = Variable<int>(leftDurationSeconds);
    }
    if (!nullToAbsent || rightDurationSeconds != null) {
      map['right_duration_seconds'] = Variable<int>(rightDurationSeconds);
    }
    if (!nullToAbsent || formulaBrand != null) {
      map['formula_brand'] = Variable<String>(formulaBrand);
    }
    if (!nullToAbsent || formulaTemp != null) {
      map['formula_temp'] = Variable<double>(formulaTemp);
    }
    if (!nullToAbsent || solidFoodReaction != null) {
      map['solid_food_reaction'] = Variable<String>(solidFoodReaction);
    }
    if (!nullToAbsent || solidFoodReactionPhotoPath != null) {
      map['solid_food_reaction_photo_path'] = Variable<String>(
        solidFoodReactionPhotoPath,
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FeedingLogsCompanion toCompanion(bool nullToAbsent) {
    return FeedingLogsCompanion(
      id: Value(id),
      babyId: Value(babyId),
      type: Value(type),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      volumeAmount: volumeAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(volumeAmount),
      volumeUnit: volumeUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(volumeUnit),
      breastSide: breastSide == null && nullToAbsent
          ? const Value.absent()
          : Value(breastSide),
      leftDurationSeconds: leftDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(leftDurationSeconds),
      rightDurationSeconds: rightDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(rightDurationSeconds),
      formulaBrand: formulaBrand == null && nullToAbsent
          ? const Value.absent()
          : Value(formulaBrand),
      formulaTemp: formulaTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(formulaTemp),
      solidFoodReaction: solidFoodReaction == null && nullToAbsent
          ? const Value.absent()
          : Value(solidFoodReaction),
      solidFoodReactionPhotoPath:
          solidFoodReactionPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(solidFoodReactionPhotoPath),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory FeedingLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedingLog(
      id: serializer.fromJson<int>(json['id']),
      babyId: serializer.fromJson<int>(json['babyId']),
      type: serializer.fromJson<String>(json['type']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      volumeAmount: serializer.fromJson<double?>(json['volumeAmount']),
      volumeUnit: serializer.fromJson<String?>(json['volumeUnit']),
      breastSide: serializer.fromJson<String?>(json['breastSide']),
      leftDurationSeconds: serializer.fromJson<int?>(
        json['leftDurationSeconds'],
      ),
      rightDurationSeconds: serializer.fromJson<int?>(
        json['rightDurationSeconds'],
      ),
      formulaBrand: serializer.fromJson<String?>(json['formulaBrand']),
      formulaTemp: serializer.fromJson<double?>(json['formulaTemp']),
      solidFoodReaction: serializer.fromJson<String?>(
        json['solidFoodReaction'],
      ),
      solidFoodReactionPhotoPath: serializer.fromJson<String?>(
        json['solidFoodReactionPhotoPath'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'babyId': serializer.toJson<int>(babyId),
      'type': serializer.toJson<String>(type),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'volumeAmount': serializer.toJson<double?>(volumeAmount),
      'volumeUnit': serializer.toJson<String?>(volumeUnit),
      'breastSide': serializer.toJson<String?>(breastSide),
      'leftDurationSeconds': serializer.toJson<int?>(leftDurationSeconds),
      'rightDurationSeconds': serializer.toJson<int?>(rightDurationSeconds),
      'formulaBrand': serializer.toJson<String?>(formulaBrand),
      'formulaTemp': serializer.toJson<double?>(formulaTemp),
      'solidFoodReaction': serializer.toJson<String?>(solidFoodReaction),
      'solidFoodReactionPhotoPath': serializer.toJson<String?>(
        solidFoodReactionPhotoPath,
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FeedingLog copyWith({
    int? id,
    int? babyId,
    String? type,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    Value<double?> volumeAmount = const Value.absent(),
    Value<String?> volumeUnit = const Value.absent(),
    Value<String?> breastSide = const Value.absent(),
    Value<int?> leftDurationSeconds = const Value.absent(),
    Value<int?> rightDurationSeconds = const Value.absent(),
    Value<String?> formulaBrand = const Value.absent(),
    Value<double?> formulaTemp = const Value.absent(),
    Value<String?> solidFoodReaction = const Value.absent(),
    Value<String?> solidFoodReactionPhotoPath = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => FeedingLog(
    id: id ?? this.id,
    babyId: babyId ?? this.babyId,
    type: type ?? this.type,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    volumeAmount: volumeAmount.present ? volumeAmount.value : this.volumeAmount,
    volumeUnit: volumeUnit.present ? volumeUnit.value : this.volumeUnit,
    breastSide: breastSide.present ? breastSide.value : this.breastSide,
    leftDurationSeconds: leftDurationSeconds.present
        ? leftDurationSeconds.value
        : this.leftDurationSeconds,
    rightDurationSeconds: rightDurationSeconds.present
        ? rightDurationSeconds.value
        : this.rightDurationSeconds,
    formulaBrand: formulaBrand.present ? formulaBrand.value : this.formulaBrand,
    formulaTemp: formulaTemp.present ? formulaTemp.value : this.formulaTemp,
    solidFoodReaction: solidFoodReaction.present
        ? solidFoodReaction.value
        : this.solidFoodReaction,
    solidFoodReactionPhotoPath: solidFoodReactionPhotoPath.present
        ? solidFoodReactionPhotoPath.value
        : this.solidFoodReactionPhotoPath,
    notes: notes.present ? notes.value : this.notes,
  );
  FeedingLog copyWithCompanion(FeedingLogsCompanion data) {
    return FeedingLog(
      id: data.id.present ? data.id.value : this.id,
      babyId: data.babyId.present ? data.babyId.value : this.babyId,
      type: data.type.present ? data.type.value : this.type,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      volumeAmount: data.volumeAmount.present
          ? data.volumeAmount.value
          : this.volumeAmount,
      volumeUnit: data.volumeUnit.present
          ? data.volumeUnit.value
          : this.volumeUnit,
      breastSide: data.breastSide.present
          ? data.breastSide.value
          : this.breastSide,
      leftDurationSeconds: data.leftDurationSeconds.present
          ? data.leftDurationSeconds.value
          : this.leftDurationSeconds,
      rightDurationSeconds: data.rightDurationSeconds.present
          ? data.rightDurationSeconds.value
          : this.rightDurationSeconds,
      formulaBrand: data.formulaBrand.present
          ? data.formulaBrand.value
          : this.formulaBrand,
      formulaTemp: data.formulaTemp.present
          ? data.formulaTemp.value
          : this.formulaTemp,
      solidFoodReaction: data.solidFoodReaction.present
          ? data.solidFoodReaction.value
          : this.solidFoodReaction,
      solidFoodReactionPhotoPath: data.solidFoodReactionPhotoPath.present
          ? data.solidFoodReactionPhotoPath.value
          : this.solidFoodReactionPhotoPath,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedingLog(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('type: $type, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('volumeAmount: $volumeAmount, ')
          ..write('volumeUnit: $volumeUnit, ')
          ..write('breastSide: $breastSide, ')
          ..write('leftDurationSeconds: $leftDurationSeconds, ')
          ..write('rightDurationSeconds: $rightDurationSeconds, ')
          ..write('formulaBrand: $formulaBrand, ')
          ..write('formulaTemp: $formulaTemp, ')
          ..write('solidFoodReaction: $solidFoodReaction, ')
          ..write('solidFoodReactionPhotoPath: $solidFoodReactionPhotoPath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    babyId,
    type,
    startTime,
    endTime,
    volumeAmount,
    volumeUnit,
    breastSide,
    leftDurationSeconds,
    rightDurationSeconds,
    formulaBrand,
    formulaTemp,
    solidFoodReaction,
    solidFoodReactionPhotoPath,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedingLog &&
          other.id == this.id &&
          other.babyId == this.babyId &&
          other.type == this.type &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.volumeAmount == this.volumeAmount &&
          other.volumeUnit == this.volumeUnit &&
          other.breastSide == this.breastSide &&
          other.leftDurationSeconds == this.leftDurationSeconds &&
          other.rightDurationSeconds == this.rightDurationSeconds &&
          other.formulaBrand == this.formulaBrand &&
          other.formulaTemp == this.formulaTemp &&
          other.solidFoodReaction == this.solidFoodReaction &&
          other.solidFoodReactionPhotoPath == this.solidFoodReactionPhotoPath &&
          other.notes == this.notes);
}

class FeedingLogsCompanion extends UpdateCompanion<FeedingLog> {
  final Value<int> id;
  final Value<int> babyId;
  final Value<String> type;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<double?> volumeAmount;
  final Value<String?> volumeUnit;
  final Value<String?> breastSide;
  final Value<int?> leftDurationSeconds;
  final Value<int?> rightDurationSeconds;
  final Value<String?> formulaBrand;
  final Value<double?> formulaTemp;
  final Value<String?> solidFoodReaction;
  final Value<String?> solidFoodReactionPhotoPath;
  final Value<String?> notes;
  const FeedingLogsCompanion({
    this.id = const Value.absent(),
    this.babyId = const Value.absent(),
    this.type = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.volumeAmount = const Value.absent(),
    this.volumeUnit = const Value.absent(),
    this.breastSide = const Value.absent(),
    this.leftDurationSeconds = const Value.absent(),
    this.rightDurationSeconds = const Value.absent(),
    this.formulaBrand = const Value.absent(),
    this.formulaTemp = const Value.absent(),
    this.solidFoodReaction = const Value.absent(),
    this.solidFoodReactionPhotoPath = const Value.absent(),
    this.notes = const Value.absent(),
  });
  FeedingLogsCompanion.insert({
    this.id = const Value.absent(),
    required int babyId,
    required String type,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.volumeAmount = const Value.absent(),
    this.volumeUnit = const Value.absent(),
    this.breastSide = const Value.absent(),
    this.leftDurationSeconds = const Value.absent(),
    this.rightDurationSeconds = const Value.absent(),
    this.formulaBrand = const Value.absent(),
    this.formulaTemp = const Value.absent(),
    this.solidFoodReaction = const Value.absent(),
    this.solidFoodReactionPhotoPath = const Value.absent(),
    this.notes = const Value.absent(),
  }) : babyId = Value(babyId),
       type = Value(type),
       startTime = Value(startTime);
  static Insertable<FeedingLog> custom({
    Expression<int>? id,
    Expression<int>? babyId,
    Expression<String>? type,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<double>? volumeAmount,
    Expression<String>? volumeUnit,
    Expression<String>? breastSide,
    Expression<int>? leftDurationSeconds,
    Expression<int>? rightDurationSeconds,
    Expression<String>? formulaBrand,
    Expression<double>? formulaTemp,
    Expression<String>? solidFoodReaction,
    Expression<String>? solidFoodReactionPhotoPath,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (babyId != null) 'baby_id': babyId,
      if (type != null) 'type': type,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (volumeAmount != null) 'volume_amount': volumeAmount,
      if (volumeUnit != null) 'volume_unit': volumeUnit,
      if (breastSide != null) 'breast_side': breastSide,
      if (leftDurationSeconds != null)
        'left_duration_seconds': leftDurationSeconds,
      if (rightDurationSeconds != null)
        'right_duration_seconds': rightDurationSeconds,
      if (formulaBrand != null) 'formula_brand': formulaBrand,
      if (formulaTemp != null) 'formula_temp': formulaTemp,
      if (solidFoodReaction != null) 'solid_food_reaction': solidFoodReaction,
      if (solidFoodReactionPhotoPath != null)
        'solid_food_reaction_photo_path': solidFoodReactionPhotoPath,
      if (notes != null) 'notes': notes,
    });
  }

  FeedingLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? babyId,
    Value<String>? type,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<double?>? volumeAmount,
    Value<String?>? volumeUnit,
    Value<String?>? breastSide,
    Value<int?>? leftDurationSeconds,
    Value<int?>? rightDurationSeconds,
    Value<String?>? formulaBrand,
    Value<double?>? formulaTemp,
    Value<String?>? solidFoodReaction,
    Value<String?>? solidFoodReactionPhotoPath,
    Value<String?>? notes,
  }) {
    return FeedingLogsCompanion(
      id: id ?? this.id,
      babyId: babyId ?? this.babyId,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      volumeAmount: volumeAmount ?? this.volumeAmount,
      volumeUnit: volumeUnit ?? this.volumeUnit,
      breastSide: breastSide ?? this.breastSide,
      leftDurationSeconds: leftDurationSeconds ?? this.leftDurationSeconds,
      rightDurationSeconds: rightDurationSeconds ?? this.rightDurationSeconds,
      formulaBrand: formulaBrand ?? this.formulaBrand,
      formulaTemp: formulaTemp ?? this.formulaTemp,
      solidFoodReaction: solidFoodReaction ?? this.solidFoodReaction,
      solidFoodReactionPhotoPath:
          solidFoodReactionPhotoPath ?? this.solidFoodReactionPhotoPath,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (babyId.present) {
      map['baby_id'] = Variable<int>(babyId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (volumeAmount.present) {
      map['volume_amount'] = Variable<double>(volumeAmount.value);
    }
    if (volumeUnit.present) {
      map['volume_unit'] = Variable<String>(volumeUnit.value);
    }
    if (breastSide.present) {
      map['breast_side'] = Variable<String>(breastSide.value);
    }
    if (leftDurationSeconds.present) {
      map['left_duration_seconds'] = Variable<int>(leftDurationSeconds.value);
    }
    if (rightDurationSeconds.present) {
      map['right_duration_seconds'] = Variable<int>(rightDurationSeconds.value);
    }
    if (formulaBrand.present) {
      map['formula_brand'] = Variable<String>(formulaBrand.value);
    }
    if (formulaTemp.present) {
      map['formula_temp'] = Variable<double>(formulaTemp.value);
    }
    if (solidFoodReaction.present) {
      map['solid_food_reaction'] = Variable<String>(solidFoodReaction.value);
    }
    if (solidFoodReactionPhotoPath.present) {
      map['solid_food_reaction_photo_path'] = Variable<String>(
        solidFoodReactionPhotoPath.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedingLogsCompanion(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('type: $type, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('volumeAmount: $volumeAmount, ')
          ..write('volumeUnit: $volumeUnit, ')
          ..write('breastSide: $breastSide, ')
          ..write('leftDurationSeconds: $leftDurationSeconds, ')
          ..write('rightDurationSeconds: $rightDurationSeconds, ')
          ..write('formulaBrand: $formulaBrand, ')
          ..write('formulaTemp: $formulaTemp, ')
          ..write('solidFoodReaction: $solidFoodReaction, ')
          ..write('solidFoodReactionPhotoPath: $solidFoodReactionPhotoPath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $SleepLogsTable extends SleepLogs
    with TableInfo<$SleepLogsTable, SleepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _babyIdMeta = const VerificationMeta('babyId');
  @override
  late final GeneratedColumn<int> babyId = GeneratedColumn<int>(
    'baby_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES babies (id)',
    ),
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, babyId, startTime, endTime, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('baby_id')) {
      context.handle(
        _babyIdMeta,
        babyId.isAcceptableOrUnknown(data['baby_id']!, _babyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_babyIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      babyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baby_id'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final int id;
  final int babyId;
  final DateTime startTime;
  final DateTime? endTime;
  final String? notes;
  const SleepLog({
    required this.id,
    required this.babyId,
    required this.startTime,
    this.endTime,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['baby_id'] = Variable<int>(babyId);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      id: Value(id),
      babyId: Value(babyId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory SleepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      id: serializer.fromJson<int>(json['id']),
      babyId: serializer.fromJson<int>(json['babyId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'babyId': serializer.toJson<int>(babyId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  SleepLog copyWith({
    int? id,
    int? babyId,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => SleepLog(
    id: id ?? this.id,
    babyId: babyId ?? this.babyId,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    notes: notes.present ? notes.value : this.notes,
  );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      id: data.id.present ? data.id.value : this.id,
      babyId: data.babyId.present ? data.babyId.value : this.babyId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepLog(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, babyId, startTime, endTime, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.id == this.id &&
          other.babyId == this.babyId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.notes == this.notes);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<int> id;
  final Value<int> babyId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<String?> notes;
  const SleepLogsCompanion({
    this.id = const Value.absent(),
    this.babyId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.notes = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    this.id = const Value.absent(),
    required int babyId,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.notes = const Value.absent(),
  }) : babyId = Value(babyId),
       startTime = Value(startTime);
  static Insertable<SleepLog> custom({
    Expression<int>? id,
    Expression<int>? babyId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (babyId != null) 'baby_id': babyId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (notes != null) 'notes': notes,
    });
  }

  SleepLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? babyId,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<String?>? notes,
  }) {
    return SleepLogsCompanion(
      id: id ?? this.id,
      babyId: babyId ?? this.babyId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (babyId.present) {
      map['baby_id'] = Variable<int>(babyId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepLogsCompanion(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $DiaperLogsTable extends DiaperLogs
    with TableInfo<$DiaperLogsTable, DiaperLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiaperLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _babyIdMeta = const VerificationMeta('babyId');
  @override
  late final GeneratedColumn<int> babyId = GeneratedColumn<int>(
    'baby_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES babies (id)',
    ),
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _consistencyMeta = const VerificationMeta(
    'consistency',
  );
  @override
  late final GeneratedColumn<String> consistency = GeneratedColumn<String>(
    'consistency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    babyId,
    startTime,
    endTime,
    type,
    consistency,
    color,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diaper_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiaperLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('baby_id')) {
      context.handle(
        _babyIdMeta,
        babyId.isAcceptableOrUnknown(data['baby_id']!, _babyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_babyIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('consistency')) {
      context.handle(
        _consistencyMeta,
        consistency.isAcceptableOrUnknown(
          data['consistency']!,
          _consistencyMeta,
        ),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiaperLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiaperLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      babyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baby_id'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      consistency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}consistency'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $DiaperLogsTable createAlias(String alias) {
    return $DiaperLogsTable(attachedDatabase, alias);
  }
}

class DiaperLog extends DataClass implements Insertable<DiaperLog> {
  final int id;
  final int babyId;
  final DateTime startTime;
  final DateTime? endTime;
  final String type;
  final String? consistency;
  final String? color;
  final String? notes;
  const DiaperLog({
    required this.id,
    required this.babyId,
    required this.startTime,
    this.endTime,
    required this.type,
    this.consistency,
    this.color,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['baby_id'] = Variable<int>(babyId);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || consistency != null) {
      map['consistency'] = Variable<String>(consistency);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  DiaperLogsCompanion toCompanion(bool nullToAbsent) {
    return DiaperLogsCompanion(
      id: Value(id),
      babyId: Value(babyId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      type: Value(type),
      consistency: consistency == null && nullToAbsent
          ? const Value.absent()
          : Value(consistency),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory DiaperLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiaperLog(
      id: serializer.fromJson<int>(json['id']),
      babyId: serializer.fromJson<int>(json['babyId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      type: serializer.fromJson<String>(json['type']),
      consistency: serializer.fromJson<String?>(json['consistency']),
      color: serializer.fromJson<String?>(json['color']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'babyId': serializer.toJson<int>(babyId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'type': serializer.toJson<String>(type),
      'consistency': serializer.toJson<String?>(consistency),
      'color': serializer.toJson<String?>(color),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  DiaperLog copyWith({
    int? id,
    int? babyId,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    String? type,
    Value<String?> consistency = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => DiaperLog(
    id: id ?? this.id,
    babyId: babyId ?? this.babyId,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    type: type ?? this.type,
    consistency: consistency.present ? consistency.value : this.consistency,
    color: color.present ? color.value : this.color,
    notes: notes.present ? notes.value : this.notes,
  );
  DiaperLog copyWithCompanion(DiaperLogsCompanion data) {
    return DiaperLog(
      id: data.id.present ? data.id.value : this.id,
      babyId: data.babyId.present ? data.babyId.value : this.babyId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      type: data.type.present ? data.type.value : this.type,
      consistency: data.consistency.present
          ? data.consistency.value
          : this.consistency,
      color: data.color.present ? data.color.value : this.color,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiaperLog(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('type: $type, ')
          ..write('consistency: $consistency, ')
          ..write('color: $color, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    babyId,
    startTime,
    endTime,
    type,
    consistency,
    color,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaperLog &&
          other.id == this.id &&
          other.babyId == this.babyId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.type == this.type &&
          other.consistency == this.consistency &&
          other.color == this.color &&
          other.notes == this.notes);
}

class DiaperLogsCompanion extends UpdateCompanion<DiaperLog> {
  final Value<int> id;
  final Value<int> babyId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<String> type;
  final Value<String?> consistency;
  final Value<String?> color;
  final Value<String?> notes;
  const DiaperLogsCompanion({
    this.id = const Value.absent(),
    this.babyId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.type = const Value.absent(),
    this.consistency = const Value.absent(),
    this.color = const Value.absent(),
    this.notes = const Value.absent(),
  });
  DiaperLogsCompanion.insert({
    this.id = const Value.absent(),
    required int babyId,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    required String type,
    this.consistency = const Value.absent(),
    this.color = const Value.absent(),
    this.notes = const Value.absent(),
  }) : babyId = Value(babyId),
       startTime = Value(startTime),
       type = Value(type);
  static Insertable<DiaperLog> custom({
    Expression<int>? id,
    Expression<int>? babyId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? type,
    Expression<String>? consistency,
    Expression<String>? color,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (babyId != null) 'baby_id': babyId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (type != null) 'type': type,
      if (consistency != null) 'consistency': consistency,
      if (color != null) 'color': color,
      if (notes != null) 'notes': notes,
    });
  }

  DiaperLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? babyId,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<String>? type,
    Value<String?>? consistency,
    Value<String?>? color,
    Value<String?>? notes,
  }) {
    return DiaperLogsCompanion(
      id: id ?? this.id,
      babyId: babyId ?? this.babyId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      consistency: consistency ?? this.consistency,
      color: color ?? this.color,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (babyId.present) {
      map['baby_id'] = Variable<int>(babyId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (consistency.present) {
      map['consistency'] = Variable<String>(consistency.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaperLogsCompanion(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('type: $type, ')
          ..write('consistency: $consistency, ')
          ..write('color: $color, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $GrowthLogsTable extends GrowthLogs
    with TableInfo<$GrowthLogsTable, GrowthLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrowthLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _babyIdMeta = const VerificationMeta('babyId');
  @override
  late final GeneratedColumn<int> babyId = GeneratedColumn<int>(
    'baby_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES babies (id)',
    ),
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _headCircumferenceMeta = const VerificationMeta(
    'headCircumference',
  );
  @override
  late final GeneratedColumn<double> headCircumference =
      GeneratedColumn<double>(
        'head_circumference',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    babyId,
    startTime,
    endTime,
    weight,
    height,
    headCircumference,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'growth_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrowthLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('baby_id')) {
      context.handle(
        _babyIdMeta,
        babyId.isAcceptableOrUnknown(data['baby_id']!, _babyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_babyIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('head_circumference')) {
      context.handle(
        _headCircumferenceMeta,
        headCircumference.isAcceptableOrUnknown(
          data['head_circumference']!,
          _headCircumferenceMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrowthLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrowthLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      babyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baby_id'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      ),
      headCircumference: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}head_circumference'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $GrowthLogsTable createAlias(String alias) {
    return $GrowthLogsTable(attachedDatabase, alias);
  }
}

class GrowthLog extends DataClass implements Insertable<GrowthLog> {
  final int id;
  final int babyId;
  final DateTime startTime;
  final DateTime? endTime;
  final double? weight;
  final double? height;
  final double? headCircumference;
  final String? notes;
  const GrowthLog({
    required this.id,
    required this.babyId,
    required this.startTime,
    this.endTime,
    this.weight,
    this.height,
    this.headCircumference,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['baby_id'] = Variable<int>(babyId);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || headCircumference != null) {
      map['head_circumference'] = Variable<double>(headCircumference);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  GrowthLogsCompanion toCompanion(bool nullToAbsent) {
    return GrowthLogsCompanion(
      id: Value(id),
      babyId: Value(babyId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      headCircumference: headCircumference == null && nullToAbsent
          ? const Value.absent()
          : Value(headCircumference),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory GrowthLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrowthLog(
      id: serializer.fromJson<int>(json['id']),
      babyId: serializer.fromJson<int>(json['babyId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      weight: serializer.fromJson<double?>(json['weight']),
      height: serializer.fromJson<double?>(json['height']),
      headCircumference: serializer.fromJson<double?>(
        json['headCircumference'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'babyId': serializer.toJson<int>(babyId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'weight': serializer.toJson<double?>(weight),
      'height': serializer.toJson<double?>(height),
      'headCircumference': serializer.toJson<double?>(headCircumference),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  GrowthLog copyWith({
    int? id,
    int? babyId,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    Value<double?> weight = const Value.absent(),
    Value<double?> height = const Value.absent(),
    Value<double?> headCircumference = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => GrowthLog(
    id: id ?? this.id,
    babyId: babyId ?? this.babyId,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    weight: weight.present ? weight.value : this.weight,
    height: height.present ? height.value : this.height,
    headCircumference: headCircumference.present
        ? headCircumference.value
        : this.headCircumference,
    notes: notes.present ? notes.value : this.notes,
  );
  GrowthLog copyWithCompanion(GrowthLogsCompanion data) {
    return GrowthLog(
      id: data.id.present ? data.id.value : this.id,
      babyId: data.babyId.present ? data.babyId.value : this.babyId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      weight: data.weight.present ? data.weight.value : this.weight,
      height: data.height.present ? data.height.value : this.height,
      headCircumference: data.headCircumference.present
          ? data.headCircumference.value
          : this.headCircumference,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrowthLog(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('headCircumference: $headCircumference, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    babyId,
    startTime,
    endTime,
    weight,
    height,
    headCircumference,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrowthLog &&
          other.id == this.id &&
          other.babyId == this.babyId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.weight == this.weight &&
          other.height == this.height &&
          other.headCircumference == this.headCircumference &&
          other.notes == this.notes);
}

class GrowthLogsCompanion extends UpdateCompanion<GrowthLog> {
  final Value<int> id;
  final Value<int> babyId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<double?> weight;
  final Value<double?> height;
  final Value<double?> headCircumference;
  final Value<String?> notes;
  const GrowthLogsCompanion({
    this.id = const Value.absent(),
    this.babyId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.headCircumference = const Value.absent(),
    this.notes = const Value.absent(),
  });
  GrowthLogsCompanion.insert({
    this.id = const Value.absent(),
    required int babyId,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.headCircumference = const Value.absent(),
    this.notes = const Value.absent(),
  }) : babyId = Value(babyId),
       startTime = Value(startTime);
  static Insertable<GrowthLog> custom({
    Expression<int>? id,
    Expression<int>? babyId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<double>? weight,
    Expression<double>? height,
    Expression<double>? headCircumference,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (babyId != null) 'baby_id': babyId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (headCircumference != null) 'head_circumference': headCircumference,
      if (notes != null) 'notes': notes,
    });
  }

  GrowthLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? babyId,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<double?>? weight,
    Value<double?>? height,
    Value<double?>? headCircumference,
    Value<String?>? notes,
  }) {
    return GrowthLogsCompanion(
      id: id ?? this.id,
      babyId: babyId ?? this.babyId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      headCircumference: headCircumference ?? this.headCircumference,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (babyId.present) {
      map['baby_id'] = Variable<int>(babyId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (headCircumference.present) {
      map['head_circumference'] = Variable<double>(headCircumference.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrowthLogsCompanion(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('headCircumference: $headCircumference, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $ActivityLogsTable extends ActivityLogs
    with TableInfo<$ActivityLogsTable, ActivityLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _babyIdMeta = const VerificationMeta('babyId');
  @override
  late final GeneratedColumn<int> babyId = GeneratedColumn<int>(
    'baby_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES babies (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _milestonesMeta = const VerificationMeta(
    'milestones',
  );
  @override
  late final GeneratedColumn<String> milestones = GeneratedColumn<String>(
    'milestones',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    babyId,
    type,
    startTime,
    endTime,
    notes,
    milestones,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('baby_id')) {
      context.handle(
        _babyIdMeta,
        babyId.isAcceptableOrUnknown(data['baby_id']!, _babyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_babyIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('milestones')) {
      context.handle(
        _milestonesMeta,
        milestones.isAcceptableOrUnknown(data['milestones']!, _milestonesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      babyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baby_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      milestones: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}milestones'],
      ),
    );
  }

  @override
  $ActivityLogsTable createAlias(String alias) {
    return $ActivityLogsTable(attachedDatabase, alias);
  }
}

class ActivityLog extends DataClass implements Insertable<ActivityLog> {
  final int id;
  final int babyId;
  final String type;
  final DateTime startTime;
  final DateTime? endTime;
  final String? notes;
  final String? milestones;
  const ActivityLog({
    required this.id,
    required this.babyId,
    required this.type,
    required this.startTime,
    this.endTime,
    this.notes,
    this.milestones,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['baby_id'] = Variable<int>(babyId);
    map['type'] = Variable<String>(type);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || milestones != null) {
      map['milestones'] = Variable<String>(milestones);
    }
    return map;
  }

  ActivityLogsCompanion toCompanion(bool nullToAbsent) {
    return ActivityLogsCompanion(
      id: Value(id),
      babyId: Value(babyId),
      type: Value(type),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      milestones: milestones == null && nullToAbsent
          ? const Value.absent()
          : Value(milestones),
    );
  }

  factory ActivityLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityLog(
      id: serializer.fromJson<int>(json['id']),
      babyId: serializer.fromJson<int>(json['babyId']),
      type: serializer.fromJson<String>(json['type']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      notes: serializer.fromJson<String?>(json['notes']),
      milestones: serializer.fromJson<String?>(json['milestones']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'babyId': serializer.toJson<int>(babyId),
      'type': serializer.toJson<String>(type),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'notes': serializer.toJson<String?>(notes),
      'milestones': serializer.toJson<String?>(milestones),
    };
  }

  ActivityLog copyWith({
    int? id,
    int? babyId,
    String? type,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> milestones = const Value.absent(),
  }) => ActivityLog(
    id: id ?? this.id,
    babyId: babyId ?? this.babyId,
    type: type ?? this.type,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    notes: notes.present ? notes.value : this.notes,
    milestones: milestones.present ? milestones.value : this.milestones,
  );
  ActivityLog copyWithCompanion(ActivityLogsCompanion data) {
    return ActivityLog(
      id: data.id.present ? data.id.value : this.id,
      babyId: data.babyId.present ? data.babyId.value : this.babyId,
      type: data.type.present ? data.type.value : this.type,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      notes: data.notes.present ? data.notes.value : this.notes,
      milestones: data.milestones.present
          ? data.milestones.value
          : this.milestones,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLog(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('type: $type, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('notes: $notes, ')
          ..write('milestones: $milestones')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, babyId, type, startTime, endTime, notes, milestones);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityLog &&
          other.id == this.id &&
          other.babyId == this.babyId &&
          other.type == this.type &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.notes == this.notes &&
          other.milestones == this.milestones);
}

class ActivityLogsCompanion extends UpdateCompanion<ActivityLog> {
  final Value<int> id;
  final Value<int> babyId;
  final Value<String> type;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<String?> notes;
  final Value<String?> milestones;
  const ActivityLogsCompanion({
    this.id = const Value.absent(),
    this.babyId = const Value.absent(),
    this.type = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.milestones = const Value.absent(),
  });
  ActivityLogsCompanion.insert({
    this.id = const Value.absent(),
    required int babyId,
    required String type,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.milestones = const Value.absent(),
  }) : babyId = Value(babyId),
       type = Value(type),
       startTime = Value(startTime);
  static Insertable<ActivityLog> custom({
    Expression<int>? id,
    Expression<int>? babyId,
    Expression<String>? type,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? notes,
    Expression<String>? milestones,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (babyId != null) 'baby_id': babyId,
      if (type != null) 'type': type,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (notes != null) 'notes': notes,
      if (milestones != null) 'milestones': milestones,
    });
  }

  ActivityLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? babyId,
    Value<String>? type,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<String?>? notes,
    Value<String?>? milestones,
  }) {
    return ActivityLogsCompanion(
      id: id ?? this.id,
      babyId: babyId ?? this.babyId,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
      milestones: milestones ?? this.milestones,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (babyId.present) {
      map['baby_id'] = Variable<int>(babyId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (milestones.present) {
      map['milestones'] = Variable<String>(milestones.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLogsCompanion(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('type: $type, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('notes: $notes, ')
          ..write('milestones: $milestones')
          ..write(')'))
        .toString();
  }
}

class $MedicalLogsTable extends MedicalLogs
    with TableInfo<$MedicalLogsTable, MedicalLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicalLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _babyIdMeta = const VerificationMeta('babyId');
  @override
  late final GeneratedColumn<int> babyId = GeneratedColumn<int>(
    'baby_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES babies (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
    'dosage',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderTimeMeta = const VerificationMeta(
    'reminderTime',
  );
  @override
  late final GeneratedColumn<DateTime> reminderTime = GeneratedColumn<DateTime>(
    'reminder_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    babyId,
    type,
    name,
    dosage,
    startTime,
    endTime,
    reminderTime,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medical_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MedicalLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('baby_id')) {
      context.handle(
        _babyIdMeta,
        babyId.isAcceptableOrUnknown(data['baby_id']!, _babyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_babyIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(
        _dosageMeta,
        dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
        _reminderTimeMeta,
        reminderTime.isAcceptableOrUnknown(
          data['reminder_time']!,
          _reminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicalLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicalLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      babyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baby_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dosage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dosage'],
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      reminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reminder_time'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $MedicalLogsTable createAlias(String alias) {
    return $MedicalLogsTable(attachedDatabase, alias);
  }
}

class MedicalLog extends DataClass implements Insertable<MedicalLog> {
  final int id;
  final int babyId;
  final String type;
  final String name;
  final String? dosage;
  final DateTime startTime;
  final DateTime? endTime;
  final DateTime? reminderTime;
  final String? notes;
  const MedicalLog({
    required this.id,
    required this.babyId,
    required this.type,
    required this.name,
    this.dosage,
    required this.startTime,
    this.endTime,
    this.reminderTime,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['baby_id'] = Variable<int>(babyId);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || dosage != null) {
      map['dosage'] = Variable<String>(dosage);
    }
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<DateTime>(reminderTime);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MedicalLogsCompanion toCompanion(bool nullToAbsent) {
    return MedicalLogsCompanion(
      id: Value(id),
      babyId: Value(babyId),
      type: Value(type),
      name: Value(name),
      dosage: dosage == null && nullToAbsent
          ? const Value.absent()
          : Value(dosage),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory MedicalLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicalLog(
      id: serializer.fromJson<int>(json['id']),
      babyId: serializer.fromJson<int>(json['babyId']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      dosage: serializer.fromJson<String?>(json['dosage']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      reminderTime: serializer.fromJson<DateTime?>(json['reminderTime']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'babyId': serializer.toJson<int>(babyId),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'dosage': serializer.toJson<String?>(dosage),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'reminderTime': serializer.toJson<DateTime?>(reminderTime),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MedicalLog copyWith({
    int? id,
    int? babyId,
    String? type,
    String? name,
    Value<String?> dosage = const Value.absent(),
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    Value<DateTime?> reminderTime = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => MedicalLog(
    id: id ?? this.id,
    babyId: babyId ?? this.babyId,
    type: type ?? this.type,
    name: name ?? this.name,
    dosage: dosage.present ? dosage.value : this.dosage,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    notes: notes.present ? notes.value : this.notes,
  );
  MedicalLog copyWithCompanion(MedicalLogsCompanion data) {
    return MedicalLog(
      id: data.id.present ? data.id.value : this.id,
      babyId: data.babyId.present ? data.babyId.value : this.babyId,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicalLog(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('dosage: $dosage, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    babyId,
    type,
    name,
    dosage,
    startTime,
    endTime,
    reminderTime,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicalLog &&
          other.id == this.id &&
          other.babyId == this.babyId &&
          other.type == this.type &&
          other.name == this.name &&
          other.dosage == this.dosage &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.reminderTime == this.reminderTime &&
          other.notes == this.notes);
}

class MedicalLogsCompanion extends UpdateCompanion<MedicalLog> {
  final Value<int> id;
  final Value<int> babyId;
  final Value<String> type;
  final Value<String> name;
  final Value<String?> dosage;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<DateTime?> reminderTime;
  final Value<String?> notes;
  const MedicalLogsCompanion({
    this.id = const Value.absent(),
    this.babyId = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.dosage = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MedicalLogsCompanion.insert({
    this.id = const Value.absent(),
    required int babyId,
    required String type,
    required String name,
    this.dosage = const Value.absent(),
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.notes = const Value.absent(),
  }) : babyId = Value(babyId),
       type = Value(type),
       name = Value(name),
       startTime = Value(startTime);
  static Insertable<MedicalLog> custom({
    Expression<int>? id,
    Expression<int>? babyId,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? dosage,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<DateTime>? reminderTime,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (babyId != null) 'baby_id': babyId,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (dosage != null) 'dosage': dosage,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (notes != null) 'notes': notes,
    });
  }

  MedicalLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? babyId,
    Value<String>? type,
    Value<String>? name,
    Value<String?>? dosage,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<DateTime?>? reminderTime,
    Value<String?>? notes,
  }) {
    return MedicalLogsCompanion(
      id: id ?? this.id,
      babyId: babyId ?? this.babyId,
      type: type ?? this.type,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      reminderTime: reminderTime ?? this.reminderTime,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (babyId.present) {
      map['baby_id'] = Variable<int>(babyId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<DateTime>(reminderTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicalLogsCompanion(')
          ..write('id: $id, ')
          ..write('babyId: $babyId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('dosage: $dosage, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BabiesTable babies = $BabiesTable(this);
  late final $FeedingLogsTable feedingLogs = $FeedingLogsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $DiaperLogsTable diaperLogs = $DiaperLogsTable(this);
  late final $GrowthLogsTable growthLogs = $GrowthLogsTable(this);
  late final $ActivityLogsTable activityLogs = $ActivityLogsTable(this);
  late final $MedicalLogsTable medicalLogs = $MedicalLogsTable(this);
  late final Index idxFeedBabyTime = Index(
    'idx_feed_baby_time',
    'CREATE INDEX idx_feed_baby_time ON feeding_logs (baby_id, start_time)',
  );
  late final Index idxFeedType = Index(
    'idx_feed_type',
    'CREATE INDEX idx_feed_type ON feeding_logs (type)',
  );
  late final Index idxSleepBabyTime = Index(
    'idx_sleep_baby_time',
    'CREATE INDEX idx_sleep_baby_time ON sleep_logs (baby_id, start_time)',
  );
  late final Index idxDiaperBabyTime = Index(
    'idx_diaper_baby_time',
    'CREATE INDEX idx_diaper_baby_time ON diaper_logs (baby_id, start_time)',
  );
  late final Index idxDiaperType = Index(
    'idx_diaper_type',
    'CREATE INDEX idx_diaper_type ON diaper_logs (type)',
  );
  late final Index idxGrowthBabyTime = Index(
    'idx_growth_baby_time',
    'CREATE INDEX idx_growth_baby_time ON growth_logs (baby_id, start_time)',
  );
  late final Index idxActivityBabyTime = Index(
    'idx_activity_baby_time',
    'CREATE INDEX idx_activity_baby_time ON activity_logs (baby_id, start_time)',
  );
  late final Index idxActivityType = Index(
    'idx_activity_type',
    'CREATE INDEX idx_activity_type ON activity_logs (type)',
  );
  late final Index idxMedicalBabyTime = Index(
    'idx_medical_baby_time',
    'CREATE INDEX idx_medical_baby_time ON medical_logs (baby_id, start_time)',
  );
  late final Index idxMedicalType = Index(
    'idx_medical_type',
    'CREATE INDEX idx_medical_type ON medical_logs (type)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    babies,
    feedingLogs,
    sleepLogs,
    diaperLogs,
    growthLogs,
    activityLogs,
    medicalLogs,
    idxFeedBabyTime,
    idxFeedType,
    idxSleepBabyTime,
    idxDiaperBabyTime,
    idxDiaperType,
    idxGrowthBabyTime,
    idxActivityBabyTime,
    idxActivityType,
    idxMedicalBabyTime,
    idxMedicalType,
  ];
}

typedef $$BabiesTableCreateCompanionBuilder =
    BabiesCompanion Function({
      Value<int> id,
      required String encryptedName,
      required String encryptedDateOfBirth,
      Value<String?> encryptedGender,
      Value<String?> remoteFolderId,
    });
typedef $$BabiesTableUpdateCompanionBuilder =
    BabiesCompanion Function({
      Value<int> id,
      Value<String> encryptedName,
      Value<String> encryptedDateOfBirth,
      Value<String?> encryptedGender,
      Value<String?> remoteFolderId,
    });

final class $$BabiesTableReferences
    extends BaseReferences<_$AppDatabase, $BabiesTable, Baby> {
  $$BabiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FeedingLogsTable, List<FeedingLog>>
  _feedingLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feedingLogs,
    aliasName: $_aliasNameGenerator(db.babies.id, db.feedingLogs.babyId),
  );

  $$FeedingLogsTableProcessedTableManager get feedingLogsRefs {
    final manager = $$FeedingLogsTableTableManager(
      $_db,
      $_db.feedingLogs,
    ).filter((f) => f.babyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_feedingLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SleepLogsTable, List<SleepLog>>
  _sleepLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sleepLogs,
    aliasName: $_aliasNameGenerator(db.babies.id, db.sleepLogs.babyId),
  );

  $$SleepLogsTableProcessedTableManager get sleepLogsRefs {
    final manager = $$SleepLogsTableTableManager(
      $_db,
      $_db.sleepLogs,
    ).filter((f) => f.babyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sleepLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DiaperLogsTable, List<DiaperLog>>
  _diaperLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.diaperLogs,
    aliasName: $_aliasNameGenerator(db.babies.id, db.diaperLogs.babyId),
  );

  $$DiaperLogsTableProcessedTableManager get diaperLogsRefs {
    final manager = $$DiaperLogsTableTableManager(
      $_db,
      $_db.diaperLogs,
    ).filter((f) => f.babyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_diaperLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GrowthLogsTable, List<GrowthLog>>
  _growthLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.growthLogs,
    aliasName: $_aliasNameGenerator(db.babies.id, db.growthLogs.babyId),
  );

  $$GrowthLogsTableProcessedTableManager get growthLogsRefs {
    final manager = $$GrowthLogsTableTableManager(
      $_db,
      $_db.growthLogs,
    ).filter((f) => f.babyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_growthLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ActivityLogsTable, List<ActivityLog>>
  _activityLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.activityLogs,
    aliasName: $_aliasNameGenerator(db.babies.id, db.activityLogs.babyId),
  );

  $$ActivityLogsTableProcessedTableManager get activityLogsRefs {
    final manager = $$ActivityLogsTableTableManager(
      $_db,
      $_db.activityLogs,
    ).filter((f) => f.babyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_activityLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MedicalLogsTable, List<MedicalLog>>
  _medicalLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.medicalLogs,
    aliasName: $_aliasNameGenerator(db.babies.id, db.medicalLogs.babyId),
  );

  $$MedicalLogsTableProcessedTableManager get medicalLogsRefs {
    final manager = $$MedicalLogsTableTableManager(
      $_db,
      $_db.medicalLogs,
    ).filter((f) => f.babyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_medicalLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BabiesTableFilterComposer
    extends Composer<_$AppDatabase, $BabiesTable> {
  $$BabiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get encryptedName => $composableBuilder(
    column: $table.encryptedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get encryptedDateOfBirth => $composableBuilder(
    column: $table.encryptedDateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get encryptedGender => $composableBuilder(
    column: $table.encryptedGender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteFolderId => $composableBuilder(
    column: $table.remoteFolderId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> feedingLogsRefs(
    Expression<bool> Function($$FeedingLogsTableFilterComposer f) f,
  ) {
    final $$FeedingLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedingLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingLogsTableFilterComposer(
            $db: $db,
            $table: $db.feedingLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sleepLogsRefs(
    Expression<bool> Function($$SleepLogsTableFilterComposer f) f,
  ) {
    final $$SleepLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sleepLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepLogsTableFilterComposer(
            $db: $db,
            $table: $db.sleepLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> diaperLogsRefs(
    Expression<bool> Function($$DiaperLogsTableFilterComposer f) f,
  ) {
    final $$DiaperLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.diaperLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiaperLogsTableFilterComposer(
            $db: $db,
            $table: $db.diaperLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> growthLogsRefs(
    Expression<bool> Function($$GrowthLogsTableFilterComposer f) f,
  ) {
    final $$GrowthLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.growthLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthLogsTableFilterComposer(
            $db: $db,
            $table: $db.growthLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activityLogsRefs(
    Expression<bool> Function($$ActivityLogsTableFilterComposer f) f,
  ) {
    final $$ActivityLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityLogsTableFilterComposer(
            $db: $db,
            $table: $db.activityLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> medicalLogsRefs(
    Expression<bool> Function($$MedicalLogsTableFilterComposer f) f,
  ) {
    final $$MedicalLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.medicalLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicalLogsTableFilterComposer(
            $db: $db,
            $table: $db.medicalLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BabiesTableOrderingComposer
    extends Composer<_$AppDatabase, $BabiesTable> {
  $$BabiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get encryptedName => $composableBuilder(
    column: $table.encryptedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get encryptedDateOfBirth => $composableBuilder(
    column: $table.encryptedDateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get encryptedGender => $composableBuilder(
    column: $table.encryptedGender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteFolderId => $composableBuilder(
    column: $table.remoteFolderId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BabiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BabiesTable> {
  $$BabiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get encryptedName => $composableBuilder(
    column: $table.encryptedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get encryptedDateOfBirth => $composableBuilder(
    column: $table.encryptedDateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get encryptedGender => $composableBuilder(
    column: $table.encryptedGender,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteFolderId => $composableBuilder(
    column: $table.remoteFolderId,
    builder: (column) => column,
  );

  Expression<T> feedingLogsRefs<T extends Object>(
    Expression<T> Function($$FeedingLogsTableAnnotationComposer a) f,
  ) {
    final $$FeedingLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedingLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.feedingLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sleepLogsRefs<T extends Object>(
    Expression<T> Function($$SleepLogsTableAnnotationComposer a) f,
  ) {
    final $$SleepLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sleepLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.sleepLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> diaperLogsRefs<T extends Object>(
    Expression<T> Function($$DiaperLogsTableAnnotationComposer a) f,
  ) {
    final $$DiaperLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.diaperLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiaperLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.diaperLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> growthLogsRefs<T extends Object>(
    Expression<T> Function($$GrowthLogsTableAnnotationComposer a) f,
  ) {
    final $$GrowthLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.growthLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.growthLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> activityLogsRefs<T extends Object>(
    Expression<T> Function($$ActivityLogsTableAnnotationComposer a) f,
  ) {
    final $$ActivityLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.activityLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> medicalLogsRefs<T extends Object>(
    Expression<T> Function($$MedicalLogsTableAnnotationComposer a) f,
  ) {
    final $$MedicalLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.medicalLogs,
      getReferencedColumn: (t) => t.babyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicalLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.medicalLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BabiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BabiesTable,
          Baby,
          $$BabiesTableFilterComposer,
          $$BabiesTableOrderingComposer,
          $$BabiesTableAnnotationComposer,
          $$BabiesTableCreateCompanionBuilder,
          $$BabiesTableUpdateCompanionBuilder,
          (Baby, $$BabiesTableReferences),
          Baby,
          PrefetchHooks Function({
            bool feedingLogsRefs,
            bool sleepLogsRefs,
            bool diaperLogsRefs,
            bool growthLogsRefs,
            bool activityLogsRefs,
            bool medicalLogsRefs,
          })
        > {
  $$BabiesTableTableManager(_$AppDatabase db, $BabiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BabiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BabiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BabiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> encryptedName = const Value.absent(),
                Value<String> encryptedDateOfBirth = const Value.absent(),
                Value<String?> encryptedGender = const Value.absent(),
                Value<String?> remoteFolderId = const Value.absent(),
              }) => BabiesCompanion(
                id: id,
                encryptedName: encryptedName,
                encryptedDateOfBirth: encryptedDateOfBirth,
                encryptedGender: encryptedGender,
                remoteFolderId: remoteFolderId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String encryptedName,
                required String encryptedDateOfBirth,
                Value<String?> encryptedGender = const Value.absent(),
                Value<String?> remoteFolderId = const Value.absent(),
              }) => BabiesCompanion.insert(
                id: id,
                encryptedName: encryptedName,
                encryptedDateOfBirth: encryptedDateOfBirth,
                encryptedGender: encryptedGender,
                remoteFolderId: remoteFolderId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BabiesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                feedingLogsRefs = false,
                sleepLogsRefs = false,
                diaperLogsRefs = false,
                growthLogsRefs = false,
                activityLogsRefs = false,
                medicalLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (feedingLogsRefs) db.feedingLogs,
                    if (sleepLogsRefs) db.sleepLogs,
                    if (diaperLogsRefs) db.diaperLogs,
                    if (growthLogsRefs) db.growthLogs,
                    if (activityLogsRefs) db.activityLogs,
                    if (medicalLogsRefs) db.medicalLogs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (feedingLogsRefs)
                        await $_getPrefetchedData<
                          Baby,
                          $BabiesTable,
                          FeedingLog
                        >(
                          currentTable: table,
                          referencedTable: $$BabiesTableReferences
                              ._feedingLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BabiesTableReferences(
                                db,
                                table,
                                p0,
                              ).feedingLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.babyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sleepLogsRefs)
                        await $_getPrefetchedData<Baby, $BabiesTable, SleepLog>(
                          currentTable: table,
                          referencedTable: $$BabiesTableReferences
                              ._sleepLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BabiesTableReferences(
                                db,
                                table,
                                p0,
                              ).sleepLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.babyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (diaperLogsRefs)
                        await $_getPrefetchedData<
                          Baby,
                          $BabiesTable,
                          DiaperLog
                        >(
                          currentTable: table,
                          referencedTable: $$BabiesTableReferences
                              ._diaperLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BabiesTableReferences(
                                db,
                                table,
                                p0,
                              ).diaperLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.babyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (growthLogsRefs)
                        await $_getPrefetchedData<
                          Baby,
                          $BabiesTable,
                          GrowthLog
                        >(
                          currentTable: table,
                          referencedTable: $$BabiesTableReferences
                              ._growthLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BabiesTableReferences(
                                db,
                                table,
                                p0,
                              ).growthLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.babyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (activityLogsRefs)
                        await $_getPrefetchedData<
                          Baby,
                          $BabiesTable,
                          ActivityLog
                        >(
                          currentTable: table,
                          referencedTable: $$BabiesTableReferences
                              ._activityLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BabiesTableReferences(
                                db,
                                table,
                                p0,
                              ).activityLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.babyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (medicalLogsRefs)
                        await $_getPrefetchedData<
                          Baby,
                          $BabiesTable,
                          MedicalLog
                        >(
                          currentTable: table,
                          referencedTable: $$BabiesTableReferences
                              ._medicalLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BabiesTableReferences(
                                db,
                                table,
                                p0,
                              ).medicalLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.babyId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BabiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BabiesTable,
      Baby,
      $$BabiesTableFilterComposer,
      $$BabiesTableOrderingComposer,
      $$BabiesTableAnnotationComposer,
      $$BabiesTableCreateCompanionBuilder,
      $$BabiesTableUpdateCompanionBuilder,
      (Baby, $$BabiesTableReferences),
      Baby,
      PrefetchHooks Function({
        bool feedingLogsRefs,
        bool sleepLogsRefs,
        bool diaperLogsRefs,
        bool growthLogsRefs,
        bool activityLogsRefs,
        bool medicalLogsRefs,
      })
    >;
typedef $$FeedingLogsTableCreateCompanionBuilder =
    FeedingLogsCompanion Function({
      Value<int> id,
      required int babyId,
      required String type,
      required DateTime startTime,
      Value<DateTime?> endTime,
      Value<double?> volumeAmount,
      Value<String?> volumeUnit,
      Value<String?> breastSide,
      Value<int?> leftDurationSeconds,
      Value<int?> rightDurationSeconds,
      Value<String?> formulaBrand,
      Value<double?> formulaTemp,
      Value<String?> solidFoodReaction,
      Value<String?> solidFoodReactionPhotoPath,
      Value<String?> notes,
    });
typedef $$FeedingLogsTableUpdateCompanionBuilder =
    FeedingLogsCompanion Function({
      Value<int> id,
      Value<int> babyId,
      Value<String> type,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<double?> volumeAmount,
      Value<String?> volumeUnit,
      Value<String?> breastSide,
      Value<int?> leftDurationSeconds,
      Value<int?> rightDurationSeconds,
      Value<String?> formulaBrand,
      Value<double?> formulaTemp,
      Value<String?> solidFoodReaction,
      Value<String?> solidFoodReactionPhotoPath,
      Value<String?> notes,
    });

final class $$FeedingLogsTableReferences
    extends BaseReferences<_$AppDatabase, $FeedingLogsTable, FeedingLog> {
  $$FeedingLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BabiesTable _babyIdTable(_$AppDatabase db) => db.babies.createAlias(
    $_aliasNameGenerator(db.feedingLogs.babyId, db.babies.id),
  );

  $$BabiesTableProcessedTableManager get babyId {
    final $_column = $_itemColumn<int>('baby_id')!;

    final manager = $$BabiesTableTableManager(
      $_db,
      $_db.babies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_babyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FeedingLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedingLogsTable> {
  $$FeedingLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeAmount => $composableBuilder(
    column: $table.volumeAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get volumeUnit => $composableBuilder(
    column: $table.volumeUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breastSide => $composableBuilder(
    column: $table.breastSide,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get leftDurationSeconds => $composableBuilder(
    column: $table.leftDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rightDurationSeconds => $composableBuilder(
    column: $table.rightDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formulaBrand => $composableBuilder(
    column: $table.formulaBrand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get formulaTemp => $composableBuilder(
    column: $table.formulaTemp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get solidFoodReaction => $composableBuilder(
    column: $table.solidFoodReaction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get solidFoodReactionPhotoPath => $composableBuilder(
    column: $table.solidFoodReactionPhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BabiesTableFilterComposer get babyId {
    final $$BabiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableFilterComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedingLogsTable> {
  $$FeedingLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeAmount => $composableBuilder(
    column: $table.volumeAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get volumeUnit => $composableBuilder(
    column: $table.volumeUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breastSide => $composableBuilder(
    column: $table.breastSide,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get leftDurationSeconds => $composableBuilder(
    column: $table.leftDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rightDurationSeconds => $composableBuilder(
    column: $table.rightDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formulaBrand => $composableBuilder(
    column: $table.formulaBrand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get formulaTemp => $composableBuilder(
    column: $table.formulaTemp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get solidFoodReaction => $composableBuilder(
    column: $table.solidFoodReaction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get solidFoodReactionPhotoPath => $composableBuilder(
    column: $table.solidFoodReactionPhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BabiesTableOrderingComposer get babyId {
    final $$BabiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableOrderingComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedingLogsTable> {
  $$FeedingLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<double> get volumeAmount => $composableBuilder(
    column: $table.volumeAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get volumeUnit => $composableBuilder(
    column: $table.volumeUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get breastSide => $composableBuilder(
    column: $table.breastSide,
    builder: (column) => column,
  );

  GeneratedColumn<int> get leftDurationSeconds => $composableBuilder(
    column: $table.leftDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rightDurationSeconds => $composableBuilder(
    column: $table.rightDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get formulaBrand => $composableBuilder(
    column: $table.formulaBrand,
    builder: (column) => column,
  );

  GeneratedColumn<double> get formulaTemp => $composableBuilder(
    column: $table.formulaTemp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get solidFoodReaction => $composableBuilder(
    column: $table.solidFoodReaction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get solidFoodReactionPhotoPath => $composableBuilder(
    column: $table.solidFoodReactionPhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BabiesTableAnnotationComposer get babyId {
    final $$BabiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableAnnotationComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedingLogsTable,
          FeedingLog,
          $$FeedingLogsTableFilterComposer,
          $$FeedingLogsTableOrderingComposer,
          $$FeedingLogsTableAnnotationComposer,
          $$FeedingLogsTableCreateCompanionBuilder,
          $$FeedingLogsTableUpdateCompanionBuilder,
          (FeedingLog, $$FeedingLogsTableReferences),
          FeedingLog,
          PrefetchHooks Function({bool babyId})
        > {
  $$FeedingLogsTableTableManager(_$AppDatabase db, $FeedingLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedingLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedingLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedingLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> babyId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<double?> volumeAmount = const Value.absent(),
                Value<String?> volumeUnit = const Value.absent(),
                Value<String?> breastSide = const Value.absent(),
                Value<int?> leftDurationSeconds = const Value.absent(),
                Value<int?> rightDurationSeconds = const Value.absent(),
                Value<String?> formulaBrand = const Value.absent(),
                Value<double?> formulaTemp = const Value.absent(),
                Value<String?> solidFoodReaction = const Value.absent(),
                Value<String?> solidFoodReactionPhotoPath =
                    const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => FeedingLogsCompanion(
                id: id,
                babyId: babyId,
                type: type,
                startTime: startTime,
                endTime: endTime,
                volumeAmount: volumeAmount,
                volumeUnit: volumeUnit,
                breastSide: breastSide,
                leftDurationSeconds: leftDurationSeconds,
                rightDurationSeconds: rightDurationSeconds,
                formulaBrand: formulaBrand,
                formulaTemp: formulaTemp,
                solidFoodReaction: solidFoodReaction,
                solidFoodReactionPhotoPath: solidFoodReactionPhotoPath,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int babyId,
                required String type,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                Value<double?> volumeAmount = const Value.absent(),
                Value<String?> volumeUnit = const Value.absent(),
                Value<String?> breastSide = const Value.absent(),
                Value<int?> leftDurationSeconds = const Value.absent(),
                Value<int?> rightDurationSeconds = const Value.absent(),
                Value<String?> formulaBrand = const Value.absent(),
                Value<double?> formulaTemp = const Value.absent(),
                Value<String?> solidFoodReaction = const Value.absent(),
                Value<String?> solidFoodReactionPhotoPath =
                    const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => FeedingLogsCompanion.insert(
                id: id,
                babyId: babyId,
                type: type,
                startTime: startTime,
                endTime: endTime,
                volumeAmount: volumeAmount,
                volumeUnit: volumeUnit,
                breastSide: breastSide,
                leftDurationSeconds: leftDurationSeconds,
                rightDurationSeconds: rightDurationSeconds,
                formulaBrand: formulaBrand,
                formulaTemp: formulaTemp,
                solidFoodReaction: solidFoodReaction,
                solidFoodReactionPhotoPath: solidFoodReactionPhotoPath,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FeedingLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({babyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (babyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.babyId,
                                referencedTable: $$FeedingLogsTableReferences
                                    ._babyIdTable(db),
                                referencedColumn: $$FeedingLogsTableReferences
                                    ._babyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FeedingLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedingLogsTable,
      FeedingLog,
      $$FeedingLogsTableFilterComposer,
      $$FeedingLogsTableOrderingComposer,
      $$FeedingLogsTableAnnotationComposer,
      $$FeedingLogsTableCreateCompanionBuilder,
      $$FeedingLogsTableUpdateCompanionBuilder,
      (FeedingLog, $$FeedingLogsTableReferences),
      FeedingLog,
      PrefetchHooks Function({bool babyId})
    >;
typedef $$SleepLogsTableCreateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      required int babyId,
      required DateTime startTime,
      Value<DateTime?> endTime,
      Value<String?> notes,
    });
typedef $$SleepLogsTableUpdateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      Value<int> babyId,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<String?> notes,
    });

final class $$SleepLogsTableReferences
    extends BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog> {
  $$SleepLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BabiesTable _babyIdTable(_$AppDatabase db) => db.babies.createAlias(
    $_aliasNameGenerator(db.sleepLogs.babyId, db.babies.id),
  );

  $$BabiesTableProcessedTableManager get babyId {
    final $_column = $_itemColumn<int>('baby_id')!;

    final manager = $$BabiesTableTableManager(
      $_db,
      $_db.babies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_babyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SleepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BabiesTableFilterComposer get babyId {
    final $$BabiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableFilterComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BabiesTableOrderingComposer get babyId {
    final $$BabiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableOrderingComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BabiesTableAnnotationComposer get babyId {
    final $$BabiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableAnnotationComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepLogsTable,
          SleepLog,
          $$SleepLogsTableFilterComposer,
          $$SleepLogsTableOrderingComposer,
          $$SleepLogsTableAnnotationComposer,
          $$SleepLogsTableCreateCompanionBuilder,
          $$SleepLogsTableUpdateCompanionBuilder,
          (SleepLog, $$SleepLogsTableReferences),
          SleepLog,
          PrefetchHooks Function({bool babyId})
        > {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> babyId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => SleepLogsCompanion(
                id: id,
                babyId: babyId,
                startTime: startTime,
                endTime: endTime,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int babyId,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => SleepLogsCompanion.insert(
                id: id,
                babyId: babyId,
                startTime: startTime,
                endTime: endTime,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SleepLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({babyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (babyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.babyId,
                                referencedTable: $$SleepLogsTableReferences
                                    ._babyIdTable(db),
                                referencedColumn: $$SleepLogsTableReferences
                                    ._babyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SleepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepLogsTable,
      SleepLog,
      $$SleepLogsTableFilterComposer,
      $$SleepLogsTableOrderingComposer,
      $$SleepLogsTableAnnotationComposer,
      $$SleepLogsTableCreateCompanionBuilder,
      $$SleepLogsTableUpdateCompanionBuilder,
      (SleepLog, $$SleepLogsTableReferences),
      SleepLog,
      PrefetchHooks Function({bool babyId})
    >;
typedef $$DiaperLogsTableCreateCompanionBuilder =
    DiaperLogsCompanion Function({
      Value<int> id,
      required int babyId,
      required DateTime startTime,
      Value<DateTime?> endTime,
      required String type,
      Value<String?> consistency,
      Value<String?> color,
      Value<String?> notes,
    });
typedef $$DiaperLogsTableUpdateCompanionBuilder =
    DiaperLogsCompanion Function({
      Value<int> id,
      Value<int> babyId,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<String> type,
      Value<String?> consistency,
      Value<String?> color,
      Value<String?> notes,
    });

final class $$DiaperLogsTableReferences
    extends BaseReferences<_$AppDatabase, $DiaperLogsTable, DiaperLog> {
  $$DiaperLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BabiesTable _babyIdTable(_$AppDatabase db) => db.babies.createAlias(
    $_aliasNameGenerator(db.diaperLogs.babyId, db.babies.id),
  );

  $$BabiesTableProcessedTableManager get babyId {
    final $_column = $_itemColumn<int>('baby_id')!;

    final manager = $$BabiesTableTableManager(
      $_db,
      $_db.babies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_babyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DiaperLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DiaperLogsTable> {
  $$DiaperLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get consistency => $composableBuilder(
    column: $table.consistency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BabiesTableFilterComposer get babyId {
    final $$BabiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableFilterComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiaperLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DiaperLogsTable> {
  $$DiaperLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get consistency => $composableBuilder(
    column: $table.consistency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BabiesTableOrderingComposer get babyId {
    final $$BabiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableOrderingComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiaperLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiaperLogsTable> {
  $$DiaperLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get consistency => $composableBuilder(
    column: $table.consistency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BabiesTableAnnotationComposer get babyId {
    final $$BabiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableAnnotationComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiaperLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiaperLogsTable,
          DiaperLog,
          $$DiaperLogsTableFilterComposer,
          $$DiaperLogsTableOrderingComposer,
          $$DiaperLogsTableAnnotationComposer,
          $$DiaperLogsTableCreateCompanionBuilder,
          $$DiaperLogsTableUpdateCompanionBuilder,
          (DiaperLog, $$DiaperLogsTableReferences),
          DiaperLog,
          PrefetchHooks Function({bool babyId})
        > {
  $$DiaperLogsTableTableManager(_$AppDatabase db, $DiaperLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiaperLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiaperLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiaperLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> babyId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> consistency = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => DiaperLogsCompanion(
                id: id,
                babyId: babyId,
                startTime: startTime,
                endTime: endTime,
                type: type,
                consistency: consistency,
                color: color,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int babyId,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                required String type,
                Value<String?> consistency = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => DiaperLogsCompanion.insert(
                id: id,
                babyId: babyId,
                startTime: startTime,
                endTime: endTime,
                type: type,
                consistency: consistency,
                color: color,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DiaperLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({babyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (babyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.babyId,
                                referencedTable: $$DiaperLogsTableReferences
                                    ._babyIdTable(db),
                                referencedColumn: $$DiaperLogsTableReferences
                                    ._babyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DiaperLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiaperLogsTable,
      DiaperLog,
      $$DiaperLogsTableFilterComposer,
      $$DiaperLogsTableOrderingComposer,
      $$DiaperLogsTableAnnotationComposer,
      $$DiaperLogsTableCreateCompanionBuilder,
      $$DiaperLogsTableUpdateCompanionBuilder,
      (DiaperLog, $$DiaperLogsTableReferences),
      DiaperLog,
      PrefetchHooks Function({bool babyId})
    >;
typedef $$GrowthLogsTableCreateCompanionBuilder =
    GrowthLogsCompanion Function({
      Value<int> id,
      required int babyId,
      required DateTime startTime,
      Value<DateTime?> endTime,
      Value<double?> weight,
      Value<double?> height,
      Value<double?> headCircumference,
      Value<String?> notes,
    });
typedef $$GrowthLogsTableUpdateCompanionBuilder =
    GrowthLogsCompanion Function({
      Value<int> id,
      Value<int> babyId,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<double?> weight,
      Value<double?> height,
      Value<double?> headCircumference,
      Value<String?> notes,
    });

final class $$GrowthLogsTableReferences
    extends BaseReferences<_$AppDatabase, $GrowthLogsTable, GrowthLog> {
  $$GrowthLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BabiesTable _babyIdTable(_$AppDatabase db) => db.babies.createAlias(
    $_aliasNameGenerator(db.growthLogs.babyId, db.babies.id),
  );

  $$BabiesTableProcessedTableManager get babyId {
    final $_column = $_itemColumn<int>('baby_id')!;

    final manager = $$BabiesTableTableManager(
      $_db,
      $_db.babies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_babyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GrowthLogsTableFilterComposer
    extends Composer<_$AppDatabase, $GrowthLogsTable> {
  $$GrowthLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get headCircumference => $composableBuilder(
    column: $table.headCircumference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BabiesTableFilterComposer get babyId {
    final $$BabiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableFilterComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrowthLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $GrowthLogsTable> {
  $$GrowthLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get headCircumference => $composableBuilder(
    column: $table.headCircumference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BabiesTableOrderingComposer get babyId {
    final $$BabiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableOrderingComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrowthLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrowthLogsTable> {
  $$GrowthLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get headCircumference => $composableBuilder(
    column: $table.headCircumference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BabiesTableAnnotationComposer get babyId {
    final $$BabiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableAnnotationComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrowthLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrowthLogsTable,
          GrowthLog,
          $$GrowthLogsTableFilterComposer,
          $$GrowthLogsTableOrderingComposer,
          $$GrowthLogsTableAnnotationComposer,
          $$GrowthLogsTableCreateCompanionBuilder,
          $$GrowthLogsTableUpdateCompanionBuilder,
          (GrowthLog, $$GrowthLogsTableReferences),
          GrowthLog,
          PrefetchHooks Function({bool babyId})
        > {
  $$GrowthLogsTableTableManager(_$AppDatabase db, $GrowthLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrowthLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrowthLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrowthLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> babyId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> headCircumference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => GrowthLogsCompanion(
                id: id,
                babyId: babyId,
                startTime: startTime,
                endTime: endTime,
                weight: weight,
                height: height,
                headCircumference: headCircumference,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int babyId,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> headCircumference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => GrowthLogsCompanion.insert(
                id: id,
                babyId: babyId,
                startTime: startTime,
                endTime: endTime,
                weight: weight,
                height: height,
                headCircumference: headCircumference,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GrowthLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({babyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (babyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.babyId,
                                referencedTable: $$GrowthLogsTableReferences
                                    ._babyIdTable(db),
                                referencedColumn: $$GrowthLogsTableReferences
                                    ._babyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GrowthLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrowthLogsTable,
      GrowthLog,
      $$GrowthLogsTableFilterComposer,
      $$GrowthLogsTableOrderingComposer,
      $$GrowthLogsTableAnnotationComposer,
      $$GrowthLogsTableCreateCompanionBuilder,
      $$GrowthLogsTableUpdateCompanionBuilder,
      (GrowthLog, $$GrowthLogsTableReferences),
      GrowthLog,
      PrefetchHooks Function({bool babyId})
    >;
typedef $$ActivityLogsTableCreateCompanionBuilder =
    ActivityLogsCompanion Function({
      Value<int> id,
      required int babyId,
      required String type,
      required DateTime startTime,
      Value<DateTime?> endTime,
      Value<String?> notes,
      Value<String?> milestones,
    });
typedef $$ActivityLogsTableUpdateCompanionBuilder =
    ActivityLogsCompanion Function({
      Value<int> id,
      Value<int> babyId,
      Value<String> type,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<String?> notes,
      Value<String?> milestones,
    });

final class $$ActivityLogsTableReferences
    extends BaseReferences<_$AppDatabase, $ActivityLogsTable, ActivityLog> {
  $$ActivityLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BabiesTable _babyIdTable(_$AppDatabase db) => db.babies.createAlias(
    $_aliasNameGenerator(db.activityLogs.babyId, db.babies.id),
  );

  $$BabiesTableProcessedTableManager get babyId {
    final $_column = $_itemColumn<int>('baby_id')!;

    final manager = $$BabiesTableTableManager(
      $_db,
      $_db.babies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_babyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActivityLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityLogsTable> {
  $$ActivityLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get milestones => $composableBuilder(
    column: $table.milestones,
    builder: (column) => ColumnFilters(column),
  );

  $$BabiesTableFilterComposer get babyId {
    final $$BabiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableFilterComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityLogsTable> {
  $$ActivityLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get milestones => $composableBuilder(
    column: $table.milestones,
    builder: (column) => ColumnOrderings(column),
  );

  $$BabiesTableOrderingComposer get babyId {
    final $$BabiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableOrderingComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityLogsTable> {
  $$ActivityLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get milestones => $composableBuilder(
    column: $table.milestones,
    builder: (column) => column,
  );

  $$BabiesTableAnnotationComposer get babyId {
    final $$BabiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableAnnotationComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityLogsTable,
          ActivityLog,
          $$ActivityLogsTableFilterComposer,
          $$ActivityLogsTableOrderingComposer,
          $$ActivityLogsTableAnnotationComposer,
          $$ActivityLogsTableCreateCompanionBuilder,
          $$ActivityLogsTableUpdateCompanionBuilder,
          (ActivityLog, $$ActivityLogsTableReferences),
          ActivityLog,
          PrefetchHooks Function({bool babyId})
        > {
  $$ActivityLogsTableTableManager(_$AppDatabase db, $ActivityLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> babyId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> milestones = const Value.absent(),
              }) => ActivityLogsCompanion(
                id: id,
                babyId: babyId,
                type: type,
                startTime: startTime,
                endTime: endTime,
                notes: notes,
                milestones: milestones,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int babyId,
                required String type,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> milestones = const Value.absent(),
              }) => ActivityLogsCompanion.insert(
                id: id,
                babyId: babyId,
                type: type,
                startTime: startTime,
                endTime: endTime,
                notes: notes,
                milestones: milestones,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActivityLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({babyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (babyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.babyId,
                                referencedTable: $$ActivityLogsTableReferences
                                    ._babyIdTable(db),
                                referencedColumn: $$ActivityLogsTableReferences
                                    ._babyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ActivityLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityLogsTable,
      ActivityLog,
      $$ActivityLogsTableFilterComposer,
      $$ActivityLogsTableOrderingComposer,
      $$ActivityLogsTableAnnotationComposer,
      $$ActivityLogsTableCreateCompanionBuilder,
      $$ActivityLogsTableUpdateCompanionBuilder,
      (ActivityLog, $$ActivityLogsTableReferences),
      ActivityLog,
      PrefetchHooks Function({bool babyId})
    >;
typedef $$MedicalLogsTableCreateCompanionBuilder =
    MedicalLogsCompanion Function({
      Value<int> id,
      required int babyId,
      required String type,
      required String name,
      Value<String?> dosage,
      required DateTime startTime,
      Value<DateTime?> endTime,
      Value<DateTime?> reminderTime,
      Value<String?> notes,
    });
typedef $$MedicalLogsTableUpdateCompanionBuilder =
    MedicalLogsCompanion Function({
      Value<int> id,
      Value<int> babyId,
      Value<String> type,
      Value<String> name,
      Value<String?> dosage,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<DateTime?> reminderTime,
      Value<String?> notes,
    });

final class $$MedicalLogsTableReferences
    extends BaseReferences<_$AppDatabase, $MedicalLogsTable, MedicalLog> {
  $$MedicalLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BabiesTable _babyIdTable(_$AppDatabase db) => db.babies.createAlias(
    $_aliasNameGenerator(db.medicalLogs.babyId, db.babies.id),
  );

  $$BabiesTableProcessedTableManager get babyId {
    final $_column = $_itemColumn<int>('baby_id')!;

    final manager = $$BabiesTableTableManager(
      $_db,
      $_db.babies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_babyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MedicalLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicalLogsTable> {
  $$MedicalLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dosage => $composableBuilder(
    column: $table.dosage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$BabiesTableFilterComposer get babyId {
    final $$BabiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableFilterComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MedicalLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicalLogsTable> {
  $$MedicalLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dosage => $composableBuilder(
    column: $table.dosage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BabiesTableOrderingComposer get babyId {
    final $$BabiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableOrderingComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MedicalLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicalLogsTable> {
  $$MedicalLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<DateTime> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$BabiesTableAnnotationComposer get babyId {
    final $$BabiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.babyId,
      referencedTable: $db.babies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BabiesTableAnnotationComposer(
            $db: $db,
            $table: $db.babies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MedicalLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicalLogsTable,
          MedicalLog,
          $$MedicalLogsTableFilterComposer,
          $$MedicalLogsTableOrderingComposer,
          $$MedicalLogsTableAnnotationComposer,
          $$MedicalLogsTableCreateCompanionBuilder,
          $$MedicalLogsTableUpdateCompanionBuilder,
          (MedicalLog, $$MedicalLogsTableReferences),
          MedicalLog,
          PrefetchHooks Function({bool babyId})
        > {
  $$MedicalLogsTableTableManager(_$AppDatabase db, $MedicalLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicalLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicalLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicalLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> babyId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> dosage = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<DateTime?> reminderTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MedicalLogsCompanion(
                id: id,
                babyId: babyId,
                type: type,
                name: name,
                dosage: dosage,
                startTime: startTime,
                endTime: endTime,
                reminderTime: reminderTime,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int babyId,
                required String type,
                required String name,
                Value<String?> dosage = const Value.absent(),
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                Value<DateTime?> reminderTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MedicalLogsCompanion.insert(
                id: id,
                babyId: babyId,
                type: type,
                name: name,
                dosage: dosage,
                startTime: startTime,
                endTime: endTime,
                reminderTime: reminderTime,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MedicalLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({babyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (babyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.babyId,
                                referencedTable: $$MedicalLogsTableReferences
                                    ._babyIdTable(db),
                                referencedColumn: $$MedicalLogsTableReferences
                                    ._babyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MedicalLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicalLogsTable,
      MedicalLog,
      $$MedicalLogsTableFilterComposer,
      $$MedicalLogsTableOrderingComposer,
      $$MedicalLogsTableAnnotationComposer,
      $$MedicalLogsTableCreateCompanionBuilder,
      $$MedicalLogsTableUpdateCompanionBuilder,
      (MedicalLog, $$MedicalLogsTableReferences),
      MedicalLog,
      PrefetchHooks Function({bool babyId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BabiesTableTableManager get babies =>
      $$BabiesTableTableManager(_db, _db.babies);
  $$FeedingLogsTableTableManager get feedingLogs =>
      $$FeedingLogsTableTableManager(_db, _db.feedingLogs);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$DiaperLogsTableTableManager get diaperLogs =>
      $$DiaperLogsTableTableManager(_db, _db.diaperLogs);
  $$GrowthLogsTableTableManager get growthLogs =>
      $$GrowthLogsTableTableManager(_db, _db.growthLogs);
  $$ActivityLogsTableTableManager get activityLogs =>
      $$ActivityLogsTableTableManager(_db, _db.activityLogs);
  $$MedicalLogsTableTableManager get medicalLogs =>
      $$MedicalLogsTableTableManager(_db, _db.medicalLogs);
}
