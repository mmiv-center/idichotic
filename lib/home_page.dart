// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dichotic/test_pages/test_list.dart';
import 'package:dichotic/settings/settings.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'learn_more.dart';

class StartApp extends StatefulWidget {
  const StartApp({super.key, required this.title});
  final String title;

  @override
  State<StartApp> createState() => StartAppState();
}

AppBar appBar(BuildContext context) { return AppBar(
          title:  Text(L10n.of(context)!.theTests, style: TextStyle(color: Colors.black)), 
          centerTitle: true,
          backgroundColor: Colors.transparent,
        );
}

var pageroute_settings = () => MaterialPageRoute(builder: (context) => SettingsPage());
var pageroute_tests = () => MaterialPageRoute(builder: (context) => const TestList(title: "Test"));
var pageroute_learn = () => MaterialPageRoute(builder: (context) => LearnMore());

class StartAppState extends State<StartApp> {
  

  @override
  Widget build(BuildContext context) {

    final bar = appBar(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = bar.preferredSize.height;

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
              child: Text(L10n.of(context)!.iDichotic, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
            Padding(
              padding: EdgeInsets.fromLTRB(0, (screenHeight-appBarHeight-statusBarHeight)*0.01, 0, (screenHeight-appBarHeight-statusBarHeight)*0.01),
              child:
            CustomButton(
              text1: Text(L10n.of(context)!.takeTests, style: TextStyle(color: Colors.black, fontSize: 16),), 
              pageroute: pageroute_tests, 
              containerHeight: (screenHeight-appBarHeight-statusBarHeight)*0.07,
              containerWidth: screenWidth*0.65,)),
            Padding(
              padding: EdgeInsets.fromLTRB(0, (screenHeight-appBarHeight-statusBarHeight)*0.01, 0, (screenHeight-appBarHeight-statusBarHeight)*0.01),
              child:
            CustomButton(
              text1: Text(L10n.of(context)!.settings, style: TextStyle(color: Colors.black, fontSize: 16)), 
              pageroute: pageroute_settings,
              containerHeight: (screenHeight-appBarHeight-statusBarHeight)*0.07,
              containerWidth: screenWidth*0.65,)),
            Padding(
              padding: EdgeInsets.fromLTRB(0, (screenHeight-appBarHeight-statusBarHeight)*0.01, 0, (screenHeight-appBarHeight-statusBarHeight)*0.13),
              child: 
            CustomButton(
              text1: Text(L10n.of(context)!.learnMore, style: TextStyle(color: Colors.black, fontSize: 16)), 
              pageroute: pageroute_learn,
              containerHeight: (screenHeight-appBarHeight-statusBarHeight)*0.07,
              containerWidth: screenWidth*0.65,)),

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