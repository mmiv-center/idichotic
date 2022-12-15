// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:audioplayers/audioplayers.dart';
import 'package:dichotic/data/exampledata.dart';
import 'practice.dart' show buildClickable, style;
import 'package:dichotic/results.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../data/types.dart';
import '../db/database.dart';

class ListenApp extends StatefulWidget {
  ListenApp({super.key, required this.title});
  final String title;

  ValueNotifier<String> selection = ValueNotifier("");

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
          title:  Text(L10n.of(context)!.listen, style: TextStyle(color: Colors.black)), 
          centerTitle: true,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
        actions: [
          TextButton(
        onPressed: () {
          testFinished();
          },
        child: Text(L10n.of(context)!.results))
        ],);
    }
  @override
  void initState() {
    // TODO: implement initState
    sounds.shuffle();
    sounds.shuffle();
    super.initState();
    String filepath = sounds[sound_index];
    play(filepath, player);
  }

  void play(String filepath, AudioPlayer player) async {
    await player.play(AssetSource(filepath));
  }

  void updateIndex() {
    setState(() {
      sound_index++;
    });
  }

  void testFinished() {
    List<Data> data = [
      Data(amount: Right_correct, id: Types.rightCorrect),
      Data(amount: Left_correct, id: Types.leftCorrect),
      Data(amount: Same_sound_correct, id: Types.homonymCorrect),
      Data(amount: Same_sound_incorrect, id: Types.homonymIncorrect),
      Data(amount: wrong, id: Types.incorrect),
    ];
    database.into(database.statemanager).insertOnConflictUpdate(StatemanagerCompanion.insert(id: const Value(0), testFinished: const Value(true)));
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
    return Scaffold(
        appBar: AppBar(
            title: Text(L10n.of(context)!.listen, style: TextStyle(color: Colors.black)),
            centerTitle: true,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)
            ),
    ),

      body: buildButtons(
          screenHeight, appBarHeight, statusBarHeight, screenWidth),
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


  Widget createContainer(String name, ListenAppState app, Text text1, double containerHeight, double containerWidth, bool highlight) {
    return CustomContainer(text1: text1, containerHeight: containerHeight, containerWidth: containerWidth, app: app, name: name, highlight: highlight,);
  }

  ValueListenableBuilder buildButtons(double screenHeight, double appBarHeight,
      double statusBarHeight, double screenWidth) {
    return ValueListenableBuilder(valueListenable: widget.selection,
        builder: (context, value, child) {
          return Center(
            //
            //crossAxisAlignment: CrossAxisAlignment.center,
              child: Column(children: [
                buildClickable(
                    createContainer,
                    this,
                    screenHeight,
                    appBarHeight,
                    statusBarHeight,
                    screenWidth,
                    value)
                ,

                Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.13, screenHeight * 0.05,
                        screenWidth * 0.13, 0),

                    child: timeline)

              ],)
          );
        });
  }
}

class CustomContainer extends StatelessWidget {
  final Text text1;
  final String name;
  final double containerHeight;
  final double containerWidth;
  final ListenAppState app;
  final bool highlight;

  CustomContainer({
    required this.text1, required this.containerHeight, required this.containerWidth, required this.app, required this.name, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        height: containerHeight,
        width: containerWidth,
        child:
        OutlinedButton(
            onPressed: () {
              app.widget.selection.value = name;
            },
            style: style(highlight),
            child: Container(child: text1))
    );
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
      if (controller.status == AnimationStatus.completed) {

        String oldfilepath = app.sounds[app.sound_index];
        List<String> sounds = oldfilepath.split("/");
        String filename = sounds[sounds.length - 1];
        List<String> sounds_2 = filename.split(".");
        String sound_2 = sounds_2[0];
        List<String> sound = sound_2.split("-");
        if (sound.contains(app.widget.selection.value)) {
          if (sound[0] == sound[1]) {
            app.Same_sound_correct++;
          } else if (sound[0] == app.widget.selection.value) {
            app.Right_correct++;
          } else {
            app.Left_correct++;
          }
        } else if (sound[0] != sound[1]) {
          app.wrong++;
        } else {
          app.Same_sound_incorrect++;
        }

        if(app.sound_index != app.sounds.length-1) {
          app.updateIndex();
          app.play(app.sounds[app.sound_index], app.player);
          controller.reset();
          controller.forward();
        } else {
          app.updateIndex();
          app.testFinished();
        }

        app.widget.selection.value = "";
    }
        setState(() {});
      });
    //controller.repeat(reverse: false);
    setState(() {
      controller.forward();
    });
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
            LinearProgressIndicator(
              value: controller.value,
              minHeight: 14,
              color: Colors.black54,
              backgroundColor: Color.fromARGB(255, 174, 173, 174),
              semanticsLabel: 'Linear progress indicator',
            ),
          ],
        ),
      );
  }
}
