
import 'package:audioplayers/audioplayers.dart';
import 'package:dichotic/db/database.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';

class RightEarCalibrate extends StatefulWidget{
  final ValueNotifier<double?> rightValue;

  const RightEarCalibrate({super.key, required this.rightValue});

  @override
  State<StatefulWidget> createState() => RightEarCalibrateState();

}

class RightEarCalibrateState extends State<RightEarCalibrate>{
  RightEarCalibrateState();


  var rightsideoffset = 0.0;
  var _value = 0.0;
  String sound = "calibration/1000R2.wav";
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
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Right Ear"),
        centerTitle: true,
        backgroundColor: Colors.transparent,

      ),
      body: Center(child: Column(
        children: [
          Icon(
            Icons.arrow_forward,
            size: 150,
          ),
          Text(
              "Focus on your right ear, slide the slider until you cannot hear the sound + ${_value}"
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
                  rightsideoffset = _value;
                });
              }),
        ),
          Row(
            children: [
              TextButton(onPressed: (){
                setState(() {
                  player.state != PlayerState.playing ? play(sound, player) : pause(player);
                });
              }, child: const Text(
                "Play/Pause",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16
                ),)),
              TextButton(onPressed: (){
                setState(() {
                  player.stop();
                  widget.rightValue.value = _value;
                  database.into(database.preferences).insertOnConflictUpdate(PreferencesCompanion.insert(id : Value(0),rightCalibrate: Value(_value)));
                });
              }, child: const Text(
                "Done",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16
                ),))
            ],

          )

        ],
      ),
      ),
    );
  }



}

