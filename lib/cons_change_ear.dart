// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:dichotic/concentrate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';



class ConschangeearApp extends StatefulWidget {
  const ConschangeearApp({super.key, required this.title, required this.ear, required this.app});
  final String title;
  final bool ear;
  final ConcentrateAppState app;

  @override
  State<StatefulWidget> createState() => ConschangeearAppState(ear : ear, app: app);
}

class ConschangeearAppState extends State<ConschangeearApp>  {
  ConschangeearAppState({required this.ear, required this.app});
  final bool ear;
  final ConcentrateAppState app;
  String Ear = " ";

  void setEar(){
    if(!ear){
      Ear = L10n.of(context)!.leftEar;
    } else {
      Ear = L10n.of(context)!.rightEar;
    }
  }
  @override
  void initState() {
    try{
      super.initState();
      startTimer();
    }catch(e){
      print(e);
    }
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    //var timer = Timer(duration, route);
    //timer.
    return Timer(duration, route);
  }

  route(){
    if(this.mounted){
      Navigator.pop(context);
      app.updateTitle(ear);
      app.play(app.sounds[app.sound_index], app.player);
      TimelineWidgetState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    setEar();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 40,
                    child:
                    Text(L10n.of(context)!.concentrateOn, style: TextStyle(fontSize: 24))),
                Container(
                    height: 40,
                    child:
                    Text(this.Ear, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                Container(
                  child:
                  Icon(Icons.arrow_back, size: 70),),
              ] ,
            )
        )
    );
  }
}

