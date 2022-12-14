// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/db/shared.dart';
import 'package:dichotic/settings/statemanager.dart';
import 'package:drift/drift.dart';
import '../settings/preferences.dart';
import '../settings/types/sex.dart';
import '../settings/types/handedness.dart';
import '../settings/types/language.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Preferences, Statemanager])
class SharedDatabase extends _$SharedDatabase {
  SharedDatabase(QueryExecutor e): super(e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // We added calibration in version 2, and the state manager table
          await m.addColumn(preferences, preferences.leftCalibrate);
          await m.addColumn(preferences, preferences.rightCalibrate);
          await m.createTable(statemanager);
        }
      },
    );
  }
}

SharedDatabase database = constructDb();