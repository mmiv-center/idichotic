// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:audioplayers/audioplayers.dart';
import 'package:dichotic/data/exampledata.dart';
import 'package:dichotic/results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class Practice extends StatefulWidget {
  Practice({super.key, required this.title});
  final String title;

  ValueNotifier<String> selection = ValueNotifier("");
  @override
  State<Practice> createState() => PracticeState();
}

var pageroute_results = (List<Data> data) => MaterialPageRoute(builder: (context) => Results(title: "Results", data: data));
class PracticeState extends State<Practice> {
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
  TimelineWidget? timeline;

  Widget appBar(context) {
    return AppBar(
      title: Text(L10n.of(context)!.listen, style: TextStyle(color: Colors.black)),
      centerTitle: true,
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      actions: [
        TextButton(
            onPressed: () {
            },
            child: Text(L10n.of(context)!.results))
      ],);
  }

  @override
  void initState() {
    super.initState();
    sounds.shuffle();
    String filepath = sounds[sound_index];
    play(filepath, player);
  }

  void play(String filepath, AudioPlayer player) async {
    await player.play(AssetSource(filepath));
  }

  void updateIndex() {
    setState(() {
      this.sound_index++;
      sound_index = sound_index % sounds.length;
    });
    if (sound_index == 0) {
      sounds.shuffle();
    }
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
            screenHeight, appBarHeight, statusBarHeight, screenWidth));
  }

  Widget createContainer(String name, PracticeState app, Text text1, double containerHeight, double containerWidth, bool highlight) {
    return CustomContainer(text1: text1, containerHeight: containerHeight, containerWidth: containerWidth, app: app, name: name, highlight: highlight,);
  }

  ValueListenableBuilder<String> buildButtons(double screenHeight,
      double appBarHeight, double statusBarHeight, double screenWidth)
  {

    return ValueListenableBuilder<String>(
        valueListenable: widget.selection,
        builder: (context, value, child) {
          return Center(
              //
              //crossAxisAlignment: CrossAxisAlignment.center,
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$sound_index", style: TextStyle(fontSize: 25)),
                ],
              ),
              buildClickable<Practice, PracticeState>(createContainer, this, screenHeight, appBarHeight,
                  statusBarHeight, screenWidth, value),
              Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.13,
                      screenHeight * 0.05, screenWidth * 0.13, 0),
                  child: timeline)
            ],
          ));
        });
  }
}

class CustomContainer extends StatelessWidget {
  final Text text1;
  final String name;
  final double containerHeight;
  final double containerWidth;
  final bool highlight;
  final PracticeState app;

  CustomContainer(
      {this.highlight = false,
      required this.text1,
      required this.containerHeight,
      required this.containerWidth,
      required this.app,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        height: containerHeight,
        width: containerWidth,
        child: OutlinedButton(
            onPressed: () {
              app.widget.selection.value = name;
            },
            style: style(highlight),
            child: Container(child: text1)));
  }
}

ButtonStyle style(bool highlight) {
  return OutlinedButton.styleFrom(
    //backgroundColor: Colors.white,
      elevation: 3,
      shadowColor: Colors.black,
      backgroundColor: highlight ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)));
}

class TimelineWidget extends StatefulWidget {
  final PracticeState app;
  TimelineWidget({required this.app});
  //const TimelineWidget({super.key});
  @override
  State<TimelineWidget> createState() => _TimelineWidgetState(app: app);
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _TimelineWidgetState extends State<TimelineWidget>
    with TickerProviderStateMixin {
  static late AnimationController controller;
  final PracticeState app;
  _TimelineWidgetState({required this.app});

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        if (controller.status == AnimationStatus.completed) {
          app.updateIndex();
          app.play(app.sounds[app.sound_index], app.player);
          controller.reset();
          controller.forward();
        }
        setState(() {});
      });
    //controller.repeat(reverse: false);
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

Row buildClickable<T extends StatefulWidget, E extends State<T>>(
    Function(String name, E, Text, double, double, bool) container,
    E state,
    double screenHeight,
    double appBarHeight,
    double statusBarHeight,
    double screenWidth,
    String value) {
  return Row(mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Column(children: <Widget>[
          container(
            "Ta",
            state,
            const Text("TA", style: TextStyle(color: Colors.black, fontSize: 24)),
            (screenHeight - appBarHeight - statusBarHeight) * 0.28,
            screenWidth * 0.4,
            value == "Ta" ? true : false,
          ),
          container(
              "Ga",
              state,
              Text("GA",
              style: TextStyle(color: Colors.black, fontSize: 24)),
              (screenHeight - appBarHeight - statusBarHeight) * 0.28,
              screenWidth * 0.4,
              value == "Ga" ? true : false),
          container(
              "Ka",
              state,
              Text("KA",
              style: TextStyle(color: Colors.black, fontSize: 24)),
              (screenHeight - appBarHeight - statusBarHeight) * 0.28,
              screenWidth * 0.4,
              value == "Ka" ? true : false)
        ]),
        Column(
          children: <Widget>[
            container(
                "Ba",
                state,
                Text("BA",
                    style: TextStyle(color: Colors.black, fontSize: 24)),
                    (screenHeight - appBarHeight - statusBarHeight) * 0.28,
                screenWidth * 0.4,
                value == "Ba" ? true : false),
            container(
                "Da",
                state,
                Text("DA",
                    style: TextStyle(color: Colors.black, fontSize: 24)),
                    (screenHeight - appBarHeight - statusBarHeight) * 0.28,
                screenWidth * 0.4,
                value == "Da" ? true : false),
            container(
                "Pa",
                state,
                Text("PA",
                  style: TextStyle(color: Colors.black, fontSize: 24)),
                (screenHeight - appBarHeight - statusBarHeight) * 0.28,
                screenWidth * 0.4,
                value == "Pa" ? true : false)
          ],
        )
      ]);
}
