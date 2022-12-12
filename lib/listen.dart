// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:dichotic/loading_cons.dart';
import 'package:dichotic/loading_listen.dart';
import 'package:dichotic/loading_practice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class TestApp extends StatefulWidget {
  const TestApp({super.key, required this.title});
  final String title;

  @override
  State<TestApp> createState() => TestAppState();
}


class TestAppState extends State<TestApp> {  
  
  AppBar appBar(BuildContext context) {
    return AppBar(
          title: Text(L10n.of(context)!.testChoose, style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
        );
  }
  var pageroute_listen = () => MaterialPageRoute(builder: (context) => const LoadingListenApp(title: "Loading"));
  var pageroute_cons = () => MaterialPageRoute(builder: (context) => const LoadingConsApp(title: "Loading"));
  var pageroute_practice = () => MaterialPageRoute(builder: (context) => const LoadingPracticeApp(title: "Loading"));

  @override
  Widget build(BuildContext context) {

    final bar = appBar(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = bar.preferredSize.height;

    return Scaffold(
        appBar: bar,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(40,10,40,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                CustomButton(
                    text1: Text(L10n.of(context)!.practice, style: TextStyle(fontSize: 20, color: Colors.black)),
                    text2: Text(L10n.of(context)!.duration_infinite, style: TextStyle(fontSize: 12, color: Colors.black)),
                    text3: Text(L10n.of(context)!.practiceInfo, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)),
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
                    pageroute: pageroute_practice),

                Container(
                    height: (screenHeight-appBarHeight-statusBarHeight) * 0.03
                ),

                CustomButton(
                  text1: Text(L10n.of(context)!.test1, style: TextStyle(fontSize: 20, color: Colors.black)),
                  text2: Text(L10n.of(context)!.duration_3, style: TextStyle(fontSize: 12, color: Colors.black)), 
                  text3: Text(L10n.of(context)!.test1Info, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)), 
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
                  pageroute: pageroute_listen),

                Container(
                  height: (screenHeight-appBarHeight-statusBarHeight) * 0.03
                ),

                CustomButton(
                  text1: Text(L10n.of(context)!.test2, style: TextStyle(fontSize: 20, color: Colors.black)),
                  text2: Text(L10n.of(context)!.duration_5, style: TextStyle(fontSize: 12, color: Colors.black)), 
                  text3: Text(L10n.of(context)!.test2Info, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)), 
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
                  pageroute: pageroute_cons),
                Container(
                  height: (screenHeight-appBarHeight-statusBarHeight) * 0.05
                ),
            ],)
        )
    );
  }
}

class CustomButton extends StatelessWidget {
  final Text text1;
  final Text text2;
  final Text text3;
  final Icon icon;
  final MaterialPageRoute Function() pageroute;

  CustomButton({
    required this.text1, required this.text2, required this.text3, required this.icon, required this.pageroute});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {Navigator.push(context, pageroute.call());},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 7,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
        ),
          child: Container(
          //height: containerHeight,
          //width: containerWidth,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            Expanded(child: text1, flex: 8), 
            Expanded(child: text2, flex: 7), 
            const Spacer(flex: 1),
            Expanded(child: text3, flex: 12), 
            const Spacer(flex: 1),
            Expanded(child: icon, flex: 6), 
            const Spacer(flex: 2),
          ]
        ))
      )
    );
  }
}