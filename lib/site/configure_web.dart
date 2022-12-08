// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'landing.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

Widget? handleWeb() {
  if (Uri.base.hasFragment) {
    return null;
  }
  window.history.pushState(null, 'iDichotic+', '');
  return Landing();
}
