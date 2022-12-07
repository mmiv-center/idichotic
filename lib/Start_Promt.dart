// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/Start_Page.dart';
import 'package:dichotic/settings/settings.dart';
import 'package:dichotic/settings/types/handedness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'db/database.dart';
import 'settings/types/sex.dart';

class Start_Promt extends StatefulWidget {
  const Start_Promt({super.key, required this.title});
  final String title;

  @override
  State<Start_Promt> createState() => Start_Page();
}

final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,

    );

class Start_Page extends State<Start_Promt> {

  List<Widget> items = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initItems();
// your code goes here
    });
  }

  var pageroute_startapp = () => MaterialPageRoute(builder: (context) => const StartApp(title: "StartAppp"));

  void initItems() async {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var _age = (age(context));
    var _sex = (sex(context));
    var _handedness = (handedness(context));
    var nativeLang = nativeLanguage(context);
    var soundLang = soundLanguage(context);
    var sound = await soundLang;
    var native = await nativeLang;
    var button = Container(
      width: screenWidth*0.7,
      height: screenHeight*0.06,
      child: OutlinedButton(
      style:OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
      ),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Continue", style: Theme.of(context).textTheme.bodyMedium), Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black)]),
      onPressed: () async {
        continueIfFilled();
      },
    ));

    setState(() {
      items.addAll([_age, _sex, _handedness, native, sound, button]);
    });
  }
  int warned = 0;

  void continueIfFilled() async {
    func() => Navigator.push(context, MaterialPageRoute(
        builder: (context) => const StartApp(title: "Start page")));
    Preference? prefs = await database.select(database.preferences)
        .getSingleOrNull();
    bool unset = prefs != null
        && prefs.soundLanguage != null;

    if (unset) {
      if (warned == 0 &&
          (prefs.nativeLanguage == null
              || prefs.sex == Sex.unspecified
              || prefs.age == null
              || prefs.handedness == Handedness.unspecified)) {
        Widget ok = OutlinedButton(
          child: Container(
            width: 65,
            child: Text(L10n.of(context)!.dismiss, style: TextStyle(color: Colors.black), textAlign: TextAlign.center,)),
          style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white, 
        elevation: 3, 
        shadowColor: Colors.black, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
        builder: (context) => const StartApp(title: "Start page")));
            warned++;
          },
        );
        // show the alert dialog
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return 
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
                title: Text("Warning", style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
                alignment: Alignment.center,
                actionsAlignment: MainAxisAlignment.center,
                content: Column(mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Text("${L10n.of(context)!.missingOption}\n", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
                      Text(L10n.of(context)!.canContinue, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
                ]),
                actions: [
                  OutlinedButton(onPressed: () => {Navigator.of(context).pop()},
                    style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, 
                    elevation: 3, 
                    shadowColor: Colors.black, 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  child: Container(
                    width: 65,
                    child: Text("Go back", style: TextStyle(color: Colors.black), textAlign: TextAlign.center,))),
                  ok,
                ],
                elevation: 5
              );
            });
        return;
      }
      func();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        color: Color.fromARGB(196, 235, 235, 235),
        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                       Icon(Icons.headphones_outlined, size: 60),
                       Text("iDichotic", style: Theme.of(context).textTheme.headlineLarge),
                       Text("Before you continue...", style: Theme.of(context).textTheme.bodyMedium),
                    ].map<Widget>((e) => e)
                  .followedBy([Text("Please fill out the following information about yourself. This will only be stored locally to give you correct test results until you send it in.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall)])
                 .followedBy(items).toList())),
            ],
          ),
        )
      )
    );
  }
}