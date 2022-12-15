// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:ui';

import 'package:dichotic/home_page.dart';
import 'package:dichotic/test_pages/loading/loading_cons.dart';
import 'loading/loading_listen.dart';
import 'package:dichotic/test_pages/loading/loading_practice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../db/database.dart';


class TestList extends StatefulWidget {
  const TestList({super.key, required this.title});
  final String title;

  @override
  State<TestList> createState() => TestListState();
}


class TestListState extends State<TestList> {

  Color test2Color = Colors.white24;
  bool finishedTest2 = false;

  @override
  void initState(){
    super.initState();
    containerLock();
  }

  Future<bool?> getField() async{
    StatemanagerData? result = await database.select(database.statemanager).getSingleOrNull();
    if(result == null){
      return false;
    }
    return result.testFinished;
  }

  void containerLock() async{
    bool? testFinished = await getField();
    if(testFinished != null && testFinished){
      updateColor(Colors.white);
      updateTestState();
    }
  }

  void updateColor(Color color){
    setState(() {
      test2Color = color;
    });
  }

  void updateTestState(){
    setState(() {
      finishedTest2 = !finishedTest2;
    });
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
          title: Text(L10n.of(context)!.testChoose, style: TextStyle(color: Colors.black)),
          centerTitle: true,
                  leading: IconButton(
            onPressed: () {
              Navigator.push(context, pageroute_start());
              },
            icon: const Icon(Icons.arrow_back_ios)
        ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
        );
  }

  var pageroute_listen = () => MaterialPageRoute(builder: (context) => const LoadingListenApp(title: "Loading"));
  var pageroute_cons = () => MaterialPageRoute(builder: (context) => const LoadingConsApp(title: "Loading"));
  var pageroute_practice = () => MaterialPageRoute(builder: (context) => const LoadingPracticeApp(title: "Loading"));
  var pageroute_start = () => MaterialPageRoute(builder: (context) => const StartApp(title: "Start"));

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget> [
                CustomButton(
                    text1: Text(L10n.of(context)!.practice, style: TextStyle(fontSize: 20, color: Colors.black)),
                    text2: Text(L10n.of(context)!.duration_infinite, style: TextStyle(fontSize: 12, color: Colors.black)),
                    text3: Text(L10n.of(context)!.practiceInfo, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)),
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
                    pageroute: pageroute_practice),

                Container(
                    height: (screenHeight-appBarHeight-statusBarHeight) * 0.05
                ),

                CustomButton(
                  text1: Text(L10n.of(context)!.test1, style: TextStyle(fontSize: 20, color: Colors.black)),
                  text2: Text(L10n.of(context)!.duration_3, style: TextStyle(fontSize: 12, color: Colors.black)),
                  text3: Text(L10n.of(context)!.test1Info, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)),

                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
                  pageroute: pageroute_listen),

                Container(
                  height: (screenHeight-appBarHeight-statusBarHeight) * 0.05
                ),
                CustomButton(
                  text1: Text(L10n.of(context)!.test2, style: TextStyle(fontSize: 20, color: Colors.black)),
                  text2: Text(L10n.of(context)!.duration_5, style: TextStyle(fontSize: 12, color: Colors.black)),
                  text3: Text(L10n.of(context)!.test2Info, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black)),
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
                  pageroute: pageroute_cons,
                  backGroundColor: test2Color,
                  finishedTest: finishedTest2,
                ),
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
  final Color backGroundColor;
  final bool finishedTest;

  CustomButton({
    required this.text1, required this.text2, required this.text3, required this.icon, required this.pageroute, this.backGroundColor = Colors.white, this.finishedTest = true});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          if(finishedTest){
            Navigator.push(context, pageroute.call());
          }
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: backGroundColor,
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