// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:dichotic/Start_Promt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dichotic/sounds.dart';
import 'package:dichotic/listen.dart';
import 'package:dichotic/concentrate.dart';



class ConschangeearApp extends StatefulWidget {
  const ConschangeearApp({super.key, required this.title, required this.ear});
  final String title;
  final bool ear;

  @override
  State<StatefulWidget> createState() => ConschangeearAppState(ear : ear);
}

class ConschangeearAppState extends State<ConschangeearApp>  {
  ConschangeearAppState({required this.ear});
  final bool ear;
  String Ear = "";

  void setEar(){
    if(ear){
      Ear = "Right";
  }else{
      Ear = "Left";
    }
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    //var timer = Timer(duration, route);
    //timer.
    return Timer(duration, route);
  }

  route(){
    Navigator.pop(context);
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
                    Text("Concentrate on the", style: TextStyle(fontSize: 24))),
                Container(
                    height: 40,
                    child:
                    Text(Ear, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                Container(
                  child:
                  Icon(Icons.arrow_forward, size: 70),),
              ] ,
            )
        )
    );
  }
}

