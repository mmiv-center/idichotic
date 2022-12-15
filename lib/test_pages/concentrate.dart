// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:audioplayers/audioplayers.dart';
import 'package:dichotic/switch_focus_ear.dart';
import 'package:dichotic/data/exampledata.dart';
import 'package:dichotic/data/types.dart';
import 'package:dichotic/results_cons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'practice.dart';

class ConcentrateApp extends StatefulWidget {
  ConcentrateApp({super.key, required this.title, required this.rightEar});
  final String title;
  final bool rightEar;

  ValueNotifier<String> selection = ValueNotifier("");

  @override
  State<ConcentrateApp> createState() => ConcentrateAppState(rightEar : rightEar);
}

var pageroute_results = (List<Data> data) => MaterialPageRoute(builder: (context) => ResultsCons(title: "Results", data: data));

class ConcentrateAppState extends State<ConcentrateApp> {
  ConcentrateAppState({
    required this.rightEar
});
  final bool rightEar;

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
  int Left_Correct = 0;
  int Left_wrong = 0;
  int Right_Correct = 0;
  int Right_wrong = 0;
  int testnr = 0;
  String title = "";
  TimelineWidget? timeline;

  @override
  void initState(){
    // TODO: implement initState
    sounds.shuffle();
    sounds.shuffle();
    super.initState();
    String filepath = sounds[sound_index];
    play(filepath, player);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      updateTitle(rightEar);
    });
  }

  void updateTitle(bool ear){
    setState(() {
      if(ear){
        title = L10n.of(context)!.concentrateOn + " " + L10n.of(context)!.right;
      }else{
        title = L10n.of(context)!.concentrateOn + " " + L10n.of(context)!.left;
      }
    });
  }
  void play(String filepath, AudioPlayer player) async{
    await player.play(AssetSource(filepath));
    //}
  }

  void resetTimeline(){
    TimelineWidgetState.reset();
  }

  void testFinished(ConcentrateAppState app){
    if(testnr == 1) {
      List<Data> data = [
        Data(amount: Right_Correct, id: Types.rightCorrect),
        Data(amount: Same_sound_correct, id: Types.homonymCorrect),
        Data(amount: Same_sound_incorrect, id: Types.homonymIncorrect),
        Data(amount: Right_wrong, id: Types.rightIncorrect),
        Data(amount: Left_Correct, id: Types.leftCorrect),
        Data(amount: Left_wrong, id: Types.leftIncorrect),
      ];
      Navigator.push(context, pageroute_results.call(data));
    }else{
      this.testnr++;
      this.sound_index = 0;

      var pageroute_cons = () => MaterialPageRoute(builder: (context) => SwitchFocusEar(title: "Loading", ear: false, app: app));
      Navigator.push(context, pageroute_cons.call());
      //player.play(AssetSource(filepath));
      //TimelineWidgetState.reset();
      //TimelineWidgetState.pause();
    }
  }

  void correct(){
    if(testnr == 0 && rightEar){
      Right_Correct++;
    }else if(testnr == 0 && !rightEar){
      Left_Correct++;
    }else if(testnr == 1 && !rightEar){
      Right_Correct++;
    }else{
      Left_Correct++;
    }
  }

  void incorrect(){
    if(testnr == 0 && rightEar){
      Right_wrong++;
    }else if(testnr == 0 && !rightEar){
      Left_wrong++;
    }else if(testnr == 1 && !rightEar){
      Right_wrong++;
    }else{
      Left_wrong++;
    }
  }

  void updateIndex(){
    setState(() {
      this.sound_index++;
    });
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
        title: Text(title, style: TextStyle(color: Colors.black)),
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
      body: buildButtons(screenHeight, appBarHeight, statusBarHeight, screenWidth),
    );
  }

  Widget createContainer(String name, ConcentrateAppState app, Text text1, double containerHeight, double containerWidth, bool highlight) {
    return CustomContainer(text1: text1, containerHeight: containerHeight, containerWidth: containerWidth, app: app, name: name, highlight: highlight,);
  }

  ValueListenableBuilder buildButtons(double screenHeight, double appBarHeight, double statusBarHeight, double screenWidth) {
    return ValueListenableBuilder(valueListenable: widget.selection, builder: (context, value, child) {
      return Center(
        child: Column( children: [
          buildClickable(createContainer, this, screenHeight, appBarHeight, statusBarHeight, screenWidth, value),

          Padding(
              padding: EdgeInsets.fromLTRB(screenWidth*0.13, screenHeight*0.05, screenWidth*0.13,0),

              child:   timeline)

        ],)
      );}
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Text text1;
  final String name;
  final double containerHeight;
  final double containerWidth;
  final ConcentrateAppState app;
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
  final ConcentrateAppState app;
  TimelineWidget({required this.app});
  @override
  State<TimelineWidget> createState() => TimelineWidgetState(app: app);

}


/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class TimelineWidgetState extends State<TimelineWidget>

    with TickerProviderStateMixin {
  static late AnimationController controller;
  final ConcentrateAppState app;
  TimelineWidgetState({required  this.app});


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
          if (sound.contains(app.widget.selection.value)) {
            if (sound[0] == sound[1]) {
              app.Same_sound_correct++;
            }else if(app.testnr == 0 && sound[0] == app.widget.selection.value){
              app.correct();
            } else if(app.testnr == 1 && sound[1] == app.widget.selection.value){
              app.correct();
            }else{
              app.incorrect();
            }
          } else if (sound[0] != sound[1]) {
            app.incorrect();
          } else {
            app.Same_sound_incorrect++;
          }

          if(app.sound_index != app.sounds.length-1) {
            app.updateIndex();
            app.play(app.sounds[app.sound_index], app.player);
            controller.reset();
            controller.forward();
          }else{
            app.updateIndex();
            app.testFinished(app);
          }
          app.widget.selection.value = "";
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

  static void pause(){
    controller.stop();
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
            backgroundColor: Colors.black54,
            semanticsLabel: 'Linear progress indicator',
          ),
        ],
      ),
    );
  }
}
