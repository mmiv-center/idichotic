// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:dichotic/loading_cons.dart';
import 'package:dichotic/loading_listen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key, required this.title});
  final String title;

  @override
  State<TestApp> createState() => TestAppState();
}


class TestAppState extends State<TestApp> {  
  
  final appBar = AppBar(
          title: const Text("Tests", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
        );

  var pageroute_listen = () => MaterialPageRoute(builder: (context) => const LoadingListenApp(title: "Loading"));
  var pageroute_cons = () => MaterialPageRoute(builder: (context) => const LoadingConsApp(title: "Loading"));

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = appBar.preferredSize.height;

    return Scaffold(
        appBar: appBar,
        body: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [

                CustomButton(
                  text1: const Text("Listen", style: TextStyle(fontSize: 20, color: Colors.black)),
                  text2: const Text("Duration: 3 minutes", style: TextStyle(fontSize: 12, color: Colors.black)), 
                  text3: const Text("In this test you get presented mutliple sounds with one so and you have three seconds to press the button with the sound you hear the best.", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)), 
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16), 
                  pageroute: pageroute_listen),

                Container(
                  height: (screenHeight-appBarHeight-statusBarHeight) * 0.05
                ),

                CustomButton(
                  text1: const Text("Concentrate", style: TextStyle(fontSize: 20, color: Colors.black)),
                  text2: const Text("Duration: 5 minutes", style: TextStyle(fontSize: 12, color: Colors.black)), 
                  text3: const Text("In this test you get presented multiple sounds and you have three seconds to press the button with the sound you hear the best.", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)), 
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16), 
                  pageroute: pageroute_cons),

                                  Container(
                  height: (screenHeight-appBarHeight-statusBarHeight) * 0.05
                ),

                CustomButton(
                  text1: const Text("Tutorial", style: TextStyle(fontSize: 20, color: Colors.black)),
                  text2: const Text("Duration: 3 minutes", style: TextStyle(fontSize: 12, color: Colors.black)), 
                  text3: const Text("If you have not taken the tests before we recommend you to go through this tutorial before you do. You will get a score based on how well you do.", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)), 
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16), 
                  pageroute: pageroute_cons),
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
      flex: 1,
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
            text1, text2, text3, icon
          ]
        ))
      )
    );
  }
}