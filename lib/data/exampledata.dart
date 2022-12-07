// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dichotic/data/types.dart';
//import 'package:flutter/foundation.dart';

class Data {
  final int amount;
  //final int n;
  final Types id;
  //final charts.Color barColor;

  Data(
      {
        required this.amount,
        //required this.n,
        required this.id,
        //required this.barColor,
      }
      );
}