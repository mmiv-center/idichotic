// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:dichotic/Start_Promt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dichotic/sounds.dart';
import 'package:dichotic/listen.dart';



class LoadingApp extends StatefulWidget {
  const LoadingApp({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => LoadingAppState();
}

class LoadingAppState extends State<LoadingApp>  {  

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
      return Timer(duration, route);
    }

    route(){
      if(this.mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ListenApp(title: "listen")
        ));
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You have 3 seconds"),
              Container(height: 6),
              CircularProgressIndicator(),
            ],
          )
        )
      );
    }
}

