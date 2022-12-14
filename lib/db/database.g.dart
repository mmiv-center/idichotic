// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Preference extends DataClass implements Insertable<Preference> {
  final int id;
  final Sex? sex;
  final Handedness? handedness;
  final int? age;
  final double? leftCalibrate;
  final double? rightCalibrate;
  final Language? nativeLanguage;
  final Language? soundLanguage;
  const Preference(
      {required this.id,
      this.sex,
      this.handedness,
      this.age,
      this.leftCalibrate,
      this.rightCalibrate,
      this.nativeLanguage,
      this.soundLanguage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || sex != null) {
      final converter = $PreferencesTable.$converter0n;
      map['sex'] = Variable<int>(converter.toSql(sex));
    }
    if (!nullToAbsent || handedness != null) {
      final converter = $PreferencesTable.$converter1n;
      map['handedness'] = Variable<int>(converter.toSql(handedness));
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || leftCalibrate != null) {
      map['left_calibrate'] = Variable<double>(leftCalibrate);
    }
    if (!nullToAbsent || rightCalibrate != null) {
      map['right_calibrate'] = Variable<double>(rightCalibrate);
    }
    if (!nullToAbsent || nativeLanguage != null) {
      final converter = $PreferencesTable.$converter2n;
      map['native_language'] =
          Variable<String>(converter.toSql(nativeLanguage));
    }
    if (!nullToAbsent || soundLanguage != null) {
      final converter = $PreferencesTable.$converter3n;
      map['sound_language'] = Variable<String>(converter.toSql(soundLanguage));
    }
    return map;
  }

  PreferencesCompanion toCompanion(bool nullToAbsent) {
    return PreferencesCompanion(
      id: Value(id),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      handedness: handedness == null && nullToAbsent
          ? const Value.absent()
          : Value(handedness),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      leftCalibrate: leftCalibrate == null && nullToAbsent
          ? const Value.absent()
          : Value(leftCalibrate),
      rightCalibrate: rightCalibrate == null && nullToAbsent
          ? const Value.absent()
          : Value(rightCalibrate),
      nativeLanguage: nativeLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(nativeLanguage),
      soundLanguage: soundLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(soundLanguage),
    );
  }

  factory Preference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Preference(
      id: serializer.fromJson<int>(json['id']),
      sex: serializer.fromJson<Sex?>(json['sex']),
      handedness: serializer.fromJson<Handedness?>(json['handedness']),
      age: serializer.fromJson<int?>(json['age']),
      leftCalibrate: serializer.fromJson<double?>(json['leftCalibrate']),
      rightCalibrate: serializer.fromJson<double?>(json['rightCalibrate']),
      nativeLanguage: serializer.fromJson<Language?>(json['nativeLanguage']),
      soundLanguage: serializer.fromJson<Language?>(json['soundLanguage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sex': serializer.toJson<Sex?>(sex),
      'handedness': serializer.toJson<Handedness?>(handedness),
      'age': serializer.toJson<int?>(age),
      'leftCalibrate': serializer.toJson<double?>(leftCalibrate),
      'rightCalibrate': serializer.toJson<double?>(rightCalibrate),
      'nativeLanguage': serializer.toJson<Language?>(nativeLanguage),
      'soundLanguage': serializer.toJson<Language?>(soundLanguage),
    };
  }

  Preference copyWith(
          {int? id,
          Value<Sex?> sex = const Value.absent(),
          Value<Handedness?> handedness = const Value.absent(),
          Value<int?> age = const Value.absent(),
          Value<double?> leftCalibrate = const Value.absent(),
          Value<double?> rightCalibrate = const Value.absent(),
          Value<Language?> nativeLanguage = const Value.absent(),
          Value<Language?> soundLanguage = const Value.absent()}) =>
      Preference(
        id: id ?? this.id,
        sex: sex.present ? sex.value : this.sex,
        handedness: handedness.present ? handedness.value : this.handedness,
        age: age.present ? age.value : this.age,
        leftCalibrate:
            leftCalibrate.present ? leftCalibrate.value : this.leftCalibrate,
        rightCalibrate:
            rightCalibrate.present ? rightCalibrate.value : this.rightCalibrate,
        nativeLanguage:
            nativeLanguage.present ? nativeLanguage.value : this.nativeLanguage,
        soundLanguage:
            soundLanguage.present ? soundLanguage.value : this.soundLanguage,
      );
  @override
  String toString() {
    return (StringBuffer('Preference(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('handedness: $handedness, ')
          ..write('age: $age, ')
          ..write('leftCalibrate: $leftCalibrate, ')
          ..write('rightCalibrate: $rightCalibrate, ')
          ..write('nativeLanguage: $nativeLanguage, ')
          ..write('soundLanguage: $soundLanguage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sex, handedness, age, leftCalibrate,
      rightCalibrate, nativeLanguage, soundLanguage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preference &&
          other.id == this.id &&
          other.sex == this.sex &&
          other.handedness == this.handedness &&
          other.age == this.age &&
          other.leftCalibrate == this.leftCalibrate &&
          other.rightCalibrate == this.rightCalibrate &&
          other.nativeLanguage == this.nativeLanguage &&
          other.soundLanguage == this.soundLanguage);
}

class PreferencesCompanion extends UpdateCompanion<Preference> {
  final Value<int> id;
  final Value<Sex?> sex;
  final Value<Handedness?> handedness;
  final Value<int?> age;
  final Value<double?> leftCalibrate;
  final Value<double?> rightCalibrate;
  final Value<Language?> nativeLanguage;
  final Value<Language?> soundLanguage;
  const PreferencesCompanion({
    this.id = const Value.absent(),
    this.sex = const Value.absent(),
    this.handedness = const Value.absent(),
    this.age = const Value.absent(),
    this.leftCalibrate = const Value.absent(),
    this.rightCalibrate = const Value.absent(),
    this.nativeLanguage = const Value.absent(),
    this.soundLanguage = const Value.absent(),
  });
  PreferencesCompanion.insert({
    this.id = const Value.absent(),
    this.sex = const Value.absent(),
    this.handedness = const Value.absent(),
    this.age = const Value.absent(),
    this.leftCalibrate = const Value.absent(),
    this.rightCalibrate = const Value.absent(),
    this.nativeLanguage = const Value.absent(),
    this.soundLanguage = const Value.absent(),
  });
  static Insertable<Preference> custom({
    Expression<int>? id,
    Expression<int>? sex,
    Expression<int>? handedness,
    Expression<int>? age,
    Expression<double>? leftCalibrate,
    Expression<double>? rightCalibrate,
    Expression<String>? nativeLanguage,
    Expression<String>? soundLanguage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sex != null) 'sex': sex,
      if (handedness != null) 'handedness': handedness,
      if (age != null) 'age': age,
      if (leftCalibrate != null) 'left_calibrate': leftCalibrate,
      if (rightCalibrate != null) 'right_calibrate': rightCalibrate,
      if (nativeLanguage != null) 'native_language': nativeLanguage,
      if (soundLanguage != null) 'sound_language': soundLanguage,
    });
  }

  PreferencesCompanion copyWith(
      {Value<int>? id,
      Value<Sex?>? sex,
      Value<Handedness?>? handedness,
      Value<int?>? age,
      Value<double?>? leftCalibrate,
      Value<double?>? rightCalibrate,
      Value<Language?>? nativeLanguage,
      Value<Language?>? soundLanguage}) {
    return PreferencesCompanion(
      id: id ?? this.id,
      sex: sex ?? this.sex,
      handedness: handedness ?? this.handedness,
      age: age ?? this.age,
      leftCalibrate: leftCalibrate ?? this.leftCalibrate,
      rightCalibrate: rightCalibrate ?? this.rightCalibrate,
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      soundLanguage: soundLanguage ?? this.soundLanguage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sex.present) {
      final converter = $PreferencesTable.$converter0n;
      map['sex'] = Variable<int>(converter.toSql(sex.value));
    }
    if (handedness.present) {
      final converter = $PreferencesTable.$converter1n;
      map['handedness'] = Variable<int>(converter.toSql(handedness.value));
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (leftCalibrate.present) {
      map['left_calibrate'] = Variable<double>(leftCalibrate.value);
    }
    if (rightCalibrate.present) {
      map['right_calibrate'] = Variable<double>(rightCalibrate.value);
    }
    if (nativeLanguage.present) {
      final converter = $PreferencesTable.$converter2n;
      map['native_language'] =
          Variable<String>(converter.toSql(nativeLanguage.value));
    }
    if (soundLanguage.present) {
      final converter = $PreferencesTable.$converter3n;
      map['sound_language'] =
          Variable<String>(converter.toSql(soundLanguage.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesCompanion(')
          ..write('id: $id, ')
          ..write('sex: $sex, ')
          ..write('handedness: $handedness, ')
          ..write('age: $age, ')
          ..write('leftCalibrate: $leftCalibrate, ')
          ..write('rightCalibrate: $rightCalibrate, ')
          ..write('nativeLanguage: $nativeLanguage, ')
          ..write('soundLanguage: $soundLanguage')
          ..write(')'))
        .toString();
  }
}

class $PreferencesTable extends Preferences
    with TableInfo<$PreferencesTable, Preference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferencesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumnWithTypeConverter<Sex?, int> sex =
      GeneratedColumn<int>('sex', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<Sex?>($PreferencesTable.$converter0n);
  final VerificationMeta _handednessMeta = const VerificationMeta('handedness');
  @override
  late final GeneratedColumnWithTypeConverter<Handedness?, int> handedness =
      GeneratedColumn<int>('handedness', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<Handedness?>($PreferencesTable.$converter1n);
  final VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _leftCalibrateMeta =
      const VerificationMeta('leftCalibrate');
  @override
  late final GeneratedColumn<double> leftCalibrate = GeneratedColumn<double>(
      'left_calibrate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  final VerificationMeta _rightCalibrateMeta =
      const VerificationMeta('rightCalibrate');
  @override
  late final GeneratedColumn<double> rightCalibrate = GeneratedColumn<double>(
      'right_calibrate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  final VerificationMeta _nativeLanguageMeta =
      const VerificationMeta('nativeLanguage');
  @override
  late final GeneratedColumnWithTypeConverter<Language?, String>
      nativeLanguage = GeneratedColumn<String>(
              'native_language', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Language?>($PreferencesTable.$converter2n);
  final VerificationMeta _soundLanguageMeta =
      const VerificationMeta('soundLanguage');
  @override
  late final GeneratedColumnWithTypeConverter<Language?, String> soundLanguage =
      GeneratedColumn<String>('sound_language', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Language?>($PreferencesTable.$converter3n);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sex,
        handedness,
        age,
        leftCalibrate,
        rightCalibrate,
        nativeLanguage,
        soundLanguage
      ];
  @override
  String get aliasedName => _alias ?? 'preferences';
  @override
  String get actualTableName => 'preferences';
  @override
  VerificationContext validateIntegrity(Insertable<Preference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_sexMeta, const VerificationResult.success());
    context.handle(_handednessMeta, const VerificationResult.success());
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('left_calibrate')) {
      context.handle(
          _leftCalibrateMeta,
          leftCalibrate.isAcceptableOrUnknown(
              data['left_calibrate']!, _leftCalibrateMeta));
    }
    if (data.containsKey('right_calibrate')) {
      context.handle(
          _rightCalibrateMeta,
          rightCalibrate.isAcceptableOrUnknown(
              data['right_calibrate']!, _rightCalibrateMeta));
    }
    context.handle(_nativeLanguageMeta, const VerificationResult.success());
    context.handle(_soundLanguageMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Preference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Preference(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sex: $PreferencesTable.$converter0n.fromSql(attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}sex'])),
      handedness: $PreferencesTable.$converter1n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}handedness'])),
      age: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      leftCalibrate: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}left_calibrate']),
      rightCalibrate: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}right_calibrate']),
      nativeLanguage: $PreferencesTable.$converter2n.fromSql(
          attachedDatabase.options.types.read(
              DriftSqlType.string, data['${effectivePrefix}native_language'])),
      soundLanguage: $PreferencesTable.$converter3n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}sound_language'])),
    );
  }

  @override
  $PreferencesTable createAlias(String alias) {
    return $PreferencesTable(attachedDatabase, alias);
  }

  static TypeConverter<Sex, int> $converter0 =
      const EnumIndexConverter<Sex>(Sex.values);
  static TypeConverter<Handedness, int> $converter1 =
      const EnumIndexConverter<Handedness>(Handedness.values);
  static TypeConverter<Language, String> $converter2 =
      const LanguageConverter();
  static TypeConverter<Language, String> $converter3 =
      const LanguageConverter();
  static TypeConverter<Sex?, int?> $converter0n =
      NullAwareTypeConverter.wrap($converter0);
  static TypeConverter<Handedness?, int?> $converter1n =
      NullAwareTypeConverter.wrap($converter1);
  static TypeConverter<Language?, String?> $converter2n =
      NullAwareTypeConverter.wrap($converter2);
  static TypeConverter<Language?, String?> $converter3n =
      NullAwareTypeConverter.wrap($converter3);
}

class StatemanagerData extends DataClass
    implements Insertable<StatemanagerData> {
  final int id;
  final bool? testFinished;
  const StatemanagerData({required this.id, this.testFinished});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || testFinished != null) {
      map['test_finished'] = Variable<bool>(testFinished);
    }
    return map;
  }

  StatemanagerCompanion toCompanion(bool nullToAbsent) {
    return StatemanagerCompanion(
      id: Value(id),
      testFinished: testFinished == null && nullToAbsent
          ? const Value.absent()
          : Value(testFinished),
    );
  }

  factory StatemanagerData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatemanagerData(
      id: serializer.fromJson<int>(json['id']),
      testFinished: serializer.fromJson<bool?>(json['testFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'testFinished': serializer.toJson<bool?>(testFinished),
    };
  }

  StatemanagerData copyWith(
          {int? id, Value<bool?> testFinished = const Value.absent()}) =>
      StatemanagerData(
        id: id ?? this.id,
        testFinished:
            testFinished.present ? testFinished.value : this.testFinished,
      );
  @override
  String toString() {
    return (StringBuffer('StatemanagerData(')
          ..write('id: $id, ')
          ..write('testFinished: $testFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, testFinished);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatemanagerData &&
          other.id == this.id &&
          other.testFinished == this.testFinished);
}

class StatemanagerCompanion extends UpdateCompanion<StatemanagerData> {
  final Value<int> id;
  final Value<bool?> testFinished;
  const StatemanagerCompanion({
    this.id = const Value.absent(),
    this.testFinished = const Value.absent(),
  });
  StatemanagerCompanion.insert({
    this.id = const Value.absent(),
    this.testFinished = const Value.absent(),
  });
  static Insertable<StatemanagerData> custom({
    Expression<int>? id,
    Expression<bool>? testFinished,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testFinished != null) 'test_finished': testFinished,
    });
  }

  StatemanagerCompanion copyWith({Value<int>? id, Value<bool?>? testFinished}) {
    return StatemanagerCompanion(
      id: id ?? this.id,
      testFinished: testFinished ?? this.testFinished,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (testFinished.present) {
      map['test_finished'] = Variable<bool>(testFinished.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatemanagerCompanion(')
          ..write('id: $id, ')
          ..write('testFinished: $testFinished')
          ..write(')'))
        .toString();
  }
}

class $StatemanagerTable extends Statemanager
    with TableInfo<$StatemanagerTable, StatemanagerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatemanagerTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _testFinishedMeta =
      const VerificationMeta('testFinished');
  @override
  late final GeneratedColumn<bool> testFinished = GeneratedColumn<bool>(
      'test_finished', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("test_finished" IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [id, testFinished];
  @override
  String get aliasedName => _alias ?? 'statemanager';
  @override
  String get actualTableName => 'statemanager';
  @override
  VerificationContext validateIntegrity(Insertable<StatemanagerData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('test_finished')) {
      context.handle(
          _testFinishedMeta,
          testFinished.isAcceptableOrUnknown(
              data['test_finished']!, _testFinishedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StatemanagerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatemanagerData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      testFinished: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}test_finished']),
    );
  }

  @override
  $StatemanagerTable createAlias(String alias) {
    return $StatemanagerTable(attachedDatabase, alias);
  }
}

abstract class _$SharedDatabase extends GeneratedDatabase {
  _$SharedDatabase(QueryExecutor e) : super(e);
  late final $PreferencesTable preferences = $PreferencesTable(this);
  late final $StatemanagerTable statemanager = $StatemanagerTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [preferences, statemanager];
}
