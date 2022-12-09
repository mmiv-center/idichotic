

import 'package:audioplayers/audioplayers.dart';
import 'package:dichotic/db/database.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';

class LeftEarCalibrate extends StatefulWidget{
  final ValueNotifier<double?> leftValue;

  const LeftEarCalibrate({super.key, required this.leftValue});


  @override
  State<StatefulWidget> createState() => LeftEarCalibrateState();

}

class LeftEarCalibrateState extends State<LeftEarCalibrate>{
  var leftsideoffset = 0.0;
  var _value = 0.0;
  String sound = "calibration/1000L2.wav";
  AudioPlayer player = AudioPlayer();


  @override
  void initState(){
    // TODO: implement initState

    super.initState();
    changeVolume(player, _value);
    play(sound, player);

  }

  void play(String filepath, AudioPlayer player) async{
    await player.play(AssetSource(filepath));

  }

  void pause(AudioPlayer player) async{
    await player.pause();

  }

  void changeVolume(AudioPlayer player, double value) async{
    await player.setVolume(value);
  }

@override
  void dispose() {
    player.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Left Ear"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(child: Column(
        children: [
          Icon(
            Icons.arrow_back,
            size: 150,
          ),
          Text(
              "Focus on your left ear, slide the slider until you cannot hear the sound + ${_value}"
          ),
          SliderTheme(
              data: SliderThemeData(
                thumbColor: Colors.black,
                inactiveTrackColor: Colors.black12,
                activeTrackColor: Colors.black45,
              ),
              child: Slider(
              min: 0,
              max: 1,
              value:_value,
              onChanged: (value){
                setState(() {
                  _value = value;
                  changeVolume(player, value);
                  leftsideoffset = _value;
                });
              })
          ),
          Row(
            children: [
              TextButton(onPressed: (){
                setState(() {
                  player.state != PlayerState.playing ? play(sound, player) : pause(player);
                  });

              }, child: Text(
                "Play/Pause",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16
              ),)),
              TextButton(onPressed: (){
                setState(() {
                  player.stop();
                  widget.leftValue.value = _value;
                  database.into(database.preferences).insertOnConflictUpdate(PreferencesCompanion.insert(id : Value(0),leftCalibrate: Value(_value)));
                });
              }, child: Text(
                  "Done",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16
              ),)),

            ],
          )

        ],
      ),
      ),
    );
  }


  
}

