// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

enum Types {
  homonymCorrect,
  homonymIncorrect,
  rightIncorrect,
  rightCorrect,
  leftIncorrect,
  leftCorrect,
  incorrect
}

String getNameForType(Types type) {
  switch(type) {
    case Types.homonymCorrect: return "Homonym";
    case Types.homonymIncorrect: return "Homonym Error";
    case Types.rightCorrect: return "Right";
    case Types.rightIncorrect: return "Right Error";
    case Types.leftCorrect: return "Left";
    case Types.leftIncorrect: return "Left Error";
    case Types.incorrect: return "Error";
    default: throw UnimplementedError("This type doesn't have a name yet");
  }
}