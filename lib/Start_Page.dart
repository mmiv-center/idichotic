// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/learn_more.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dichotic/listen.dart';
import 'package:dichotic/settings/settings.dart';

class StartApp extends StatefulWidget {
  const StartApp({super.key, required this.title});
  final String title;

  @override
  State<StartApp> createState() => StartAppState();
}

  final appBar = AppBar(
          title: const Text("The Tests", style: TextStyle(color: Colors.black)), 
          centerTitle: true,
          backgroundColor: Colors.transparent,
        );

var pageroute_settings = () => MaterialPageRoute(builder: (context) => const SettingsPage());
var pageroute_tests = () => MaterialPageRoute(builder: (context) => const TestApp(title: "Test"));
var pageroute_learn = () => MaterialPageRoute(builder: (context) => LearnMore());

class StartAppState extends State<StartApp> {
  

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = appBar.preferredSize.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Icon(Icons.headphones_outlined, size: 60)),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, (screenHeight-appBarHeight-statusBarHeight)*0.24),
              child: Text("iDichotic", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
            Padding(
              padding: EdgeInsets.fromLTRB(0, (screenHeight-appBarHeight-statusBarHeight)*0.01, 0, (screenHeight-appBarHeight-statusBarHeight)*0.01),
              child:
            CustomButton(
              text1: Text("Take the test", style: TextStyle(color: Colors.black, fontSize: 16),), 
              pageroute: pageroute_tests, 
              containerHeight: (screenHeight-appBarHeight-statusBarHeight)*0.07,
              containerWidth: screenWidth*0.65,)),
            Padding(
              padding: EdgeInsets.fromLTRB(0, (screenHeight-appBarHeight-statusBarHeight)*0.01, 0, (screenHeight-appBarHeight-statusBarHeight)*0.01),
              child:
            CustomButton(
              text1: Text("Settings", style: TextStyle(color: Colors.black, fontSize: 16)), 
              pageroute: pageroute_settings,
              containerHeight: (screenHeight-appBarHeight-statusBarHeight)*0.07,
              containerWidth: screenWidth*0.65,)),
            Padding(
              padding: EdgeInsets.fromLTRB(0, (screenHeight-appBarHeight-statusBarHeight)*0.01, 0, (screenHeight-appBarHeight-statusBarHeight)*0.13),
              child: 
            CustomButton(
              text1: Text("Learn More", style: TextStyle(color: Colors.black, fontSize: 16)), 
              pageroute: pageroute_learn,
              containerHeight: (screenHeight-appBarHeight-statusBarHeight)*0.07,
              containerWidth: screenWidth*0.65,))
          ],
        ),
      ),
    );
  }
}



class CustomButton extends StatelessWidget {
  final Text text1;
  final MaterialPageRoute Function() pageroute;
  final double containerHeight;
  final double containerWidth;

  CustomButton({
    required this.text1, required this.pageroute, required this.containerHeight, required this.containerWidth});
  

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(0.0),
      child: OutlinedButton(           
      onPressed: () {Navigator.push(context, pageroute.call());},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white, 
        elevation: 7, 
        shadowColor: Colors.black, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        child: Container(
          height: containerHeight,
          width: containerWidth,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          text1, 
          ]
        ))
      )
    );
  }

}