// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/settings/dropdown.dart';
import 'package:dichotic/settings/languages.dart';
import 'package:dichotic/settings/types/handedness.dart';
import 'package:dichotic/settings/types/language.dart';
import 'package:dichotic/settings/types/sex.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsState();
}

final soundLanguages = ["eng", "nor", "est", "fin", "ger"];

var icons = [
  Icons.abc,
  Icons.label,
  Icons.g_mobiledata,
  Icons.offline_bolt,
  Icons.face,
  Icons.sailing_rounded
];

class SettingsState extends State<SettingsPage> {
  final List<Widget> items = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        initItems();
      });
    });
  }

  void initItems() async {

    var sound = soundLanguage(context);
    var lang = await nativeLanguage(context);
    var soundLang = await sound;

    var widgets = <Widget>[
      (Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            padding: EdgeInsets.all(15),
            child: Text("Hearing",
                style: Theme.of(context).textTheme.headlineMedium))
      ])),
      Container(
          decoration: const BoxDecoration(
            border: Border(
            top: BorderSide(width: 1.5, color: Colors.black),
            bottom: BorderSide(width: 1.5, color: Colors.black),
          )),
          child: soundLang),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            padding: EdgeInsets.all(15),
            child: Text("Personal",
                style: Theme.of(context).textTheme.headlineMedium))
      ]),
      Container(
          decoration: const BoxDecoration(
          border: Border(
          top: BorderSide(width: 1.5, color: Colors.black),
            //bottom: BorderSide(width: 1.5, color: Colors.black),
          )),
          padding: EdgeInsets.all(4),
          child: sex(context)),
      Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(width: 1.5, color: Colors.black),
            //bottom: BorderSide(width: 1.5, color: Colors.black),
          )),
          padding: EdgeInsets.all(4),
          child: handedness(context)),
      Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 1.5, color: Colors.black),
            //bottom: BorderSide(width: 1.5, color: Colors.black),
          )),
          padding: EdgeInsets.all(4),
          child: age(context)),
      Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 1.5, color: Colors.black),
            bottom: BorderSide(width: 1.5, color: Colors.black),
          )),
          child: lang)
    ];

    setState(() {
      items.addAll(widgets);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text(L10n.of(context)!.settings,
                style: Theme.of(context).textTheme.headlineLarge)),
        body: Container(
            alignment: Alignment.center,
            //height: screenHeight*0.4,
            //padding: EdgeInsets.all(10),
            child: Form(
                key: GlobalKey<FormState>(),
                child: Column(
                  children: items,
                ))));
  }
}

Future<Widget> soundLanguage(context) async {
  Map<String, dynamic> map = Map.from(await Languages.get(context));

  map.removeWhere((key, value) => !soundLanguages.contains(value.iso_639_2));
  return Dropdown(
      icon: const Icon(Icons.sign_language),
      description: L10n.of(context)!.soundLanguage,
      options: map);
}

Future<Widget> nativeLanguage(context) async {
  Map<String, Language?> map = {L10n.of(context)!.unspecified: null};
  map.addAll(await Languages.get(context));
  map.removeWhere((key, value) => value != null && value.iso_639_1 == "");

  return Dropdown(
      icon: const Icon(Icons.language),
      description: L10n.of(context)!.nativeLanguage,
      options: map);
}

Widget sex(context) {
  var map = {
    L10n.of(context)!.unspecified: Sex.unspecified,
    L10n.of(context)!.male: Sex.male,
    L10n.of(context)!.female: Sex.female,
    L10n.of(context)!.otherSex: Sex.other,
  };
  return Dropdown(
      icon: const Icon(Icons.transgender),
      description: L10n.of(context)!.sex,
      options: map);
}

Widget handedness(context) {
  var map = {
    L10n.of(context)!.unspecified: Handedness.unspecified,
    L10n.of(context)!.right: Handedness.right,
    L10n.of(context)!.left: Handedness.left,
    L10n.of(context)!.both: Handedness.both,
  };
  return Dropdown(
      icon: const Icon(Icons.handshake),
      description: L10n.of(context)!.handedness,
      options: map);
}

Widget age(context) {
  Map<String, dynamic> map = {L10n.of(context)!.unspecified: null};
  for (int i = 0; i < 100; i++) {
    map[i.toString()] = i;
  }

  return Dropdown(
      icon: const Icon(Icons.timelapse),
      description: L10n.of(context)!.age,
      options: map);
}
