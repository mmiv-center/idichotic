// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:dichotic/Start_Promt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dichotic/sounds.dart';
import 'package:dichotic/listen.dart';



class LoadingListenApp extends StatefulWidget {
  const LoadingListenApp({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => LoadingListenAppState();
}

class LoadingListenAppState extends State<LoadingListenApp>  {  

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

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = appBar.preferredSize.height;

      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
              height: (screenHeight-appBarHeight-statusBarHeight) * 0.14,
              child: Text("Three seconds until\nthe test start", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)),
              TimelineWidget(),
            ],
          )
        )
      );
    }
}


class TimelineWidget extends StatefulWidget {
  const TimelineWidget({super.key});

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}


class _TimelineWidgetState extends State<TimelineWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularProgressIndicator(
              value: controller.value,
              strokeWidth: 7,
              color: Color.fromARGB(255, 241, 153, 182),
              semanticsLabel: 'Circular progress indicator',
            ),
          ],
        ),
      );
  }
}

