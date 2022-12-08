// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:developer';

import 'package:dichotic/scroll.dart';
import 'package:dichotic/settings/languages.dart';
import 'package:dichotic/settings/settings.dart';
import 'package:dichotic/settings/types/handedness.dart';
import 'package:dichotic/settings/types/sex.dart';
import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../db/database.dart';
import 'preferences.dart';

class Dropdown<T> extends StatefulWidget {
  Dropdown({super.key,
    required this.icon,
    required this.description,
    required this.options,
  });

  final Icon icon;
  final String description;
  final Map<String, dynamic> options;

  @override
  State<StatefulWidget> createState() {
    return DropdownState(icon: icon,
        description: description,
        choices: options);
  }
}
final Preferences options = Preferences();


class DropdownState extends State<Dropdown> {
  DropdownState({
    required this.icon,
    required this.description,
    required this.choices,
  });

  Icon icon;
  String description;
  int selectionValue = -1;
  ValueNotifier<int> selection = ValueNotifier(-1);
  Map<String, dynamic> choices;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        setDefault();
      });
    });
  }
  
  void setDefault() async {
    var element = await getFields(description);
    selectionValue = element != null ? choices.values.toList().indexOf(element) : -1;
    selection = ValueNotifier(selectionValue);
  }
  

  T? update<T extends Enum>(String selection, T fallback, Map<String, dynamic> map) {
    T? option = fallback;
    if (map.keys.contains(selection)) {
      option = map[selection];
    }
    return option;
  }
  PreferencesCompanion updateSex(String selection) {
    Sex? sex = update(selection, Sex.unspecified, choices);
    return PreferencesCompanion(id: const Value(0), sex: Value(sex));
  }

  PreferencesCompanion updateHand(String selection) {
    Handedness? handedness = update(selection, Handedness.unspecified, choices);
    return PreferencesCompanion(id: const Value(0), handedness: Value(handedness));
  }

  Future<PreferencesCompanion> updateSoundLanguage(String selection) async {
    var result = await Languages.get(context);
    if (!soundLanguages.contains(result[selection]!.iso_639_2)) {
      log("Somehow received an undefined sound language as input");
      return const PreferencesCompanion(id: Value(0));
    }
    return PreferencesCompanion(id: const Value(0), soundLanguage: Value(result[selection]));
  }

  Future<PreferencesCompanion> updateNativeLanguage(String selection) async {
    var result = await Languages.get(context);
    return PreferencesCompanion(id: const Value(0), nativeLanguage: Value(result[selection]));
  }

  PreferencesCompanion updateAge(String selection) {
    var result = int.tryParse(selection);
    return PreferencesCompanion(id: const Value(0), age: Value(result));
  }

  dynamic getFields(String option) async {
    L10n? lang = L10n.of(context);
    lang!;
    Preference? result = await database.select(database.preferences).getSingleOrNull();
    if (result == null) {
      return null;
    }
    Map values = {
      lang.sex: result.sex,
      lang.handedness: result.handedness,
      lang.nativeLanguage: result.nativeLanguage,
      lang.soundLanguage: result.soundLanguage,
      lang.age: result.age
    };
    if (values.containsKey(option)) {
      return values[option];
    }
    else {
      log("Attempted to retrieve unrecognized field");
      throw InvalidDataException;
    }
      // Call the method matching option that was changed
  }

  void updateFields(String option, String selection) async {
    Map values = {
      L10n.of(context)!.sex: updateSex,
      L10n.of(context)!.handedness: updateHand,
      L10n.of(context)!.nativeLanguage: updateNativeLanguage,
      L10n.of(context)!.soundLanguage: updateSoundLanguage,
      L10n.of(context)!.age: updateAge
    };
    if (values.containsKey(option)) {
      // Call the method matching option that was changed
      updateWithCompanion(await values[option].call(selection));
    }
    else {
      log("Attempted to update unrecognized field");
    }
  }

  void updateWithCompanion(PreferencesCompanion companion) async {
    await database
      .into(database.preferences)
      .insertOnConflictUpdate(companion);
  }

  void updateSelection(int value) {
    selectionValue = value;
    selection.value = selectionValue;
    updateFields(description, choices.keys.toList()[value]);
  }

  Widget picker(String option){

    return CupertinoPageScaffold(
      child: ScrollConfiguration(
        behavior: CrossPlatformScrollBehaviour(),
        child:
          CupertinoPicker(
            itemExtent: 20,
            onSelectedItemChanged: (int selection) {
              setState(() {
                updateSelection(selection);
              });
            },
            scrollController: FixedExtentScrollController(initialItem: selectionValue),
            //children: [sex(context), language(context)],
            children: List<Widget>.generate(choices.length, (index) {
              return Center(child: Text(choices.keys.toList()[index]));
            })
          )
      )
    );
  }

  void showPicker(Widget child) {
    setState(() {
      if (selectionValue == null) {
        updateSelection(0);
      }
    });
    showCupertinoModalPopup(context: context, builder:
      (BuildContext context) => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 0.0),
        child: SafeArea(top: false, child: child),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        builder: (BuildContext context, int value, Widget? child) {
          return CupertinoButton(
            //child: Text(choices.keys.toList()[value]),
            onPressed: () => showPicker(picker(description)),
            //padding: EdgeInsets.zero,
              child: Row(
                children: <Widget> [
                  Expanded(

                    child: Text(description, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.left)
                  ),
                  Expanded(child: Align(alignment: Alignment.bottomRight,
                    child: value != -1 ?
                        Text(choices.keys.toList()[value], style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right)
                        : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: 16)
                    ))
                  ],
                ),
            );
          },
        valueListenable: selection,
    );
  }
}