// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/settings/types/handedness.dart';
import 'package:dichotic/settings/types/language.dart';
import 'package:drift/drift.dart';

import 'types/sex.dart';

class Preferences extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get sex => intEnum<Sex>().nullable()();
  IntColumn get handedness => intEnum<Handedness>().nullable()();
  IntColumn get age => integer().nullable()();

  RealColumn get leftCalibrate => real().nullable()();//withDefault(const Constant(1.0))();
  RealColumn get rightCalibrate => real().nullable()();//(const Constant(1.0))();

  TextColumn get nativeLanguage => text().map(const LanguageConverter()).nullable()();
  TextColumn get soundLanguage => text().map(const LanguageConverter()).nullable()();


}