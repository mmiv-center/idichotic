import 'package:drift/drift.dart';
import '../../lib/settings/types/sex.dart';

class Preferences extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get age => integer()();
  IntColumn get handedness => intEnum<Sex>
}