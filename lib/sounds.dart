// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:audioplayers/audioplayers.dart';
import 'package:dichotic/data/exampledata.dart';
import 'package:dichotic/data/exampledata.dart';
import 'package:dichotic/results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/types.dart';

class ListenApp extends StatefulWidget {
  const ListenApp({super.key, required this.title});
  final String title;

  @override
  State<ListenApp> createState() => ListenAppState();
}

var pageroute_results = (List<Data> data) => MaterialPageRoute(builder: (context) => Results(title: "Results", data: data));
class ListenAppState extends State<ListenApp> {
  AudioPlayer player = AudioPlayer();
  List<String> sounds = ["audio/Ba-Ba.wav", "audio/Ba-Da.wav",
    "audio/Ba-Ga.wav", "audio/Ba-Ka.wav", "audio/Ba-Pa.wav",
    "audio/Ba-Ta.wav", "audio/Da-Ba.wav", "audio/Da-Da.wav",
    "audio/Da-Ga.wav", "audio/Da-Ka.wav", "audio/Da-Pa.wav",
    "audio/Da-Ta.wav", "audio/Ga-Ba.wav", "audio/Ga-Da.wav",
    "audio/Ga-Ga.wav", "audio/Ga-Ka.wav", "audio/Ga-Pa.wav",
    "audio/Ga-Ta.wav", "audio/Ka-Ba.wav", "audio/Ka-Da.wav",
    "audio/Ka-Ga.wav", "audio/Ka-Ka.wav", "audio/Ka-Pa.wav",
    "audio/Ka-Ta.wav", "audio/Pa-Ba.wav", "audio/Pa-Da.wav",
    "audio/Pa-Ga.wav", "audio/Pa-Ka.wav", "audio/Pa-Pa.wav",
    "audio/Pa-Ta.wav", "audio/Ta-Ba.wav", "audio/Ta-Da.wav",
    "audio/Ta-Ga.wav", "audio/Ta-Ka.wav", "audio/Ta-Pa.wav",
    "audio/Ta-Ta.wav"];
  int sound_index = 0;
  int Same_sound_correct = 0;
  int Same_sound_incorrect = 0;
  int Left_correct = 0;
  int Right_correct = 0;
  int wrong = 0;
  TimelineWidget? timeline;
    Widget appBar(context) {
      return AppBar(
          title: const Text("Listen", style: TextStyle(color: Colors.black)), 
          centerTitle: true,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
        actions: [
          TextButton(
        onPressed: () {
          testFinished();
          },
        child: const Text("Results"))
        ],);
    }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    String filepath = sounds[sound_index];
    play(filepath, player);
  }

  void play(String filepath, AudioPlayer player) async{
    await player.play(AssetSource(filepath));
    //}
  }

  void testFinished(){
    List<Data> data = [
      Data(amount: Right_correct, id: Types.rightCorrect),
      Data(amount: Left_correct, id: Types.leftCorrect),
      Data(amount: Same_sound_correct, id: Types.homonymCorrect),
      Data(amount: Same_sound_incorrect, id: Types.homonymIncorrect),
      Data(amount: wrong, id: Types.incorrect),
    ];
    Navigator.push(context, pageroute_results.call(data));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = appBar.preferredSize.height;
    timeline = TimelineWidget(app: this);
    sounds.shuffle();
    sounds.shuffle();
    return Scaffold(
        appBar: AppBar(
            title: const Text("Listen", style: TextStyle(color: Colors.black)),
            centerTitle: true,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            actions: [
            TextButton(
            onPressed: () {
              testFinished();
              },
        child: const Text("Results")),
    ],
    ),
        body: Center(
        //
        //crossAxisAlignment: CrossAxisAlignment.center,
       child: Column( children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Column(
          children: <Widget> [
          CustomContainer(
            name: "Ta",
            app: this,
            text1: Text("TA", style: TextStyle(color: Colors.black, fontSize: 24)),
            containerHeight: (screenHeight-appBarHeight-statusBarHeight) * 0.28,
            containerWidth: screenWidth * 0.4),
          CustomContainer(
            name: "Ga",
              app: this,
            text1: Text("GA", style: TextStyle(color: Colors.black, fontSize: 24)),
            containerHeight: (screenHeight-appBarHeight-statusBarHeight) * 0.28,
            containerWidth: screenWidth * 0.4),
          CustomContainer(
            name: "Ka",
              app: this,
            text1: Text("KA", style: TextStyle(color: Colors.black, fontSize: 24)),
            containerHeight: (screenHeight-appBarHeight-statusBarHeight) * 0.28,
            containerWidth: screenWidth * 0.4)]),

          Column(
          children: <Widget> [
          CustomContainer(
            name: "Ba",
              app: this,
            text1: Text("BA", style: TextStyle(color: Colors.black, fontSize: 24)),
            containerHeight: (screenHeight-appBarHeight-statusBarHeight) * 0.28,
            containerWidth: screenWidth * 0.4),
          CustomContainer(
            name: "Da",
              app: this,
            text1: Text("DA", style: TextStyle(color: Colors.black, fontSize: 24)),
            containerHeight: (screenHeight-appBarHeight-statusBarHeight) * 0.28,
            containerWidth: screenWidth * 0.4),
          CustomContainer(
            text1: Text("PA", style: TextStyle(color: Colors.black, fontSize: 24)),
            containerHeight: (screenHeight-appBarHeight-statusBarHeight) * 0.28,
            containerWidth: screenWidth * 0.4,
            name: "Pa",
            app: this,)
          
        ],)
          ]
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(screenWidth*0.13, screenHeight*0.05, screenWidth*0.13,0),

            child:   timeline)

      ],)
    ),
      /*
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.construction),
              label: 'Main Results'

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              label: 'Details'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_outlined),
              label: 'Animation'
          ),
        ],
      ),*/
    );

  }
}

class CustomContainer extends StatelessWidget {
  final Text text1;
  final String name;
  final double containerHeight;
  final double containerWidth;
  final ListenAppState app;

  CustomContainer({
    required this.text1, required this.containerHeight, required this.containerWidth, required this.app, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        height: containerHeight,
        width: containerWidth,
        child:
        OutlinedButton(
            onPressed: () {
              if (app.sound_index < app.sounds.length) {
                scoreLogic();
                app.sound_index++;
              }
              if (app.sound_index < app.sounds.length) {
                String filepath = app.sounds[app.sound_index];
                app.play(filepath, app.player);
                _TimelineWidgetState.reset();
              } else {
                app.testFinished();
              }
            },
            style: OutlinedButton.styleFrom(
              //backgroundColor: Colors.white,
                elevation: 3,
                shadowColor: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Container(child: text1))
    );
  }

  void scoreLogic() {
    String oldfilepath = app.sounds[app.sound_index];
    List<String> sounds = oldfilepath.split("/");
    String filename = sounds[sounds.length - 1];
    List<String> sounds_2 = filename.split(".");
    String sound_2 = sounds_2[0];
    List<String> sound = sound_2.split("-");
    if (sound.contains(name)) {
      if (sound[0] == sound[1]) {
        app.Same_sound_correct++;
      } else if (sound[0] == name) {
        app.Right_correct++;
      } else {
        app.Left_correct++;
      }
    } else if (sound[0] != sound[1]) {
      app.wrong++;
    } else {
      app.Same_sound_incorrect++;
    }
  }
}


class TimelineWidget extends StatefulWidget {
  final ListenAppState app;
  TimelineWidget({required this.app});
  //const TimelineWidget({super.key});
  @override
  State<TimelineWidget> createState() => _TimelineWidgetState(app: app);

}


/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _TimelineWidgetState extends State<TimelineWidget>

    with TickerProviderStateMixin {
    static late AnimationController controller;
    final ListenAppState app;
    _TimelineWidgetState({required  this.app});


  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
          if (app.sound_index < app.sounds.length){
            if (controller.status == AnimationStatus.completed) {
              String oldfilepath = app.sounds[app.sound_index];
              List<String> sounds = oldfilepath.split("/");
              String filename = sounds[sounds.length - 1];
              List<String> sounds_2 = filename.split(".");
              String sound_2 = sounds_2[0];
              List<String> sound = sound_2.split("-");
              if(sound[0]!= sound[1]){
                app.wrong++;
              }else{
                app.Same_sound_incorrect++;
              }
              app.wrong++;
              if(app.sound_index != app.sounds.length-1) {
                app.sound_index++;
                app.play(app.sounds[app.sound_index], app.player);
                controller.reset();
                controller.forward();
              }else{
                app.testFinished();
              }
            }
        }
        setState(() {});
      });
    //controller.repeat(reverse: false);
    controller.forward();
    super.initState();
  }

  static void reset(){
    controller.reset();
    controller.forward();
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
            LinearProgressIndicator(
              value: controller.value,
              minHeight: 14,
              color: Color.fromARGB(255, 241, 153, 182),
              backgroundColor: Color.fromARGB(255, 174, 173, 174),
              semanticsLabel: 'Linear progress indicator',
            ),
          ],
        ),
      );
  }
}
