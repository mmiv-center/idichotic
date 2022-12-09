// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:drift/drift.dart';


class Statemanager extends Table {

  IntColumn get id => integer().autoIncrement()();
  BoolColumn get testFinished => boolean().nullable()();

}