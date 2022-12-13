// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/charts/resultschart_cons_left.dart';
import 'package:dichotic/charts/resultschart_cons_right.dart';
import 'package:dichotic/data/exampledata.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'results.dart';

class ResultsCons extends StatefulWidget {
  ResultsCons({super.key, required this.title, required this.data});

  final List<Data> data;
  final String title;

  @override
  State<ResultsCons> createState() => _MyHomePageState(data: data);
}

class VideoPlayerExample extends StatefulWidget{
  const VideoPlayerExample({super.key});
  @override
  State<StatefulWidget> createState() => _VideoPlayerScreenState();

}
class _VideoPlayerScreenState extends State{
  late VideoPlayerController _videoPlayerController;
  //late Future<void> _initVideoPlayerFuture;

  void initState(){
    super.initState();
    _videoPlayerController = VideoPlayerController.asset("assets/video/NL.mp4");
    //_initVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.initialize().then((_) {setState(() {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
    });
  });

  }


  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _videoPlayerController.value.isInitialized ? AspectRatio(aspectRatio:
      _videoPlayerController.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController)
      ): Container()
    );
  }

}

class _MyHomePageState extends State<ResultsCons> {
  _MyHomePageState({required this.data});


  final List<Data> data;


  List<Widget> _pages(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return <Widget> [
    results(screenWidth, screenHeight, context),

    details(screenWidth, context)];

  }

  Center results(double screenWidth, double screenHeight, BuildContext context) {
    return Center(
    child:
    Container(
      padding: EdgeInsets.fromLTRB(screenWidth*0.04, 0, screenWidth*0.04, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
            Expanded(child: Text("Well done!", style: Theme.of(context).textTheme.titleLarge)),
            Expanded(child: Text("You were correct 75.5% of the time", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left)),
            Row(children: [const Spacer(flex: 1), Expanded(flex: 6, child: Text("Forced Right Results", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left)), const Spacer(flex: 6)]),
            Expanded(flex: 2, child: ResultsChartRCons(data))]
            .followedBy([
            Row(children: [const Spacer(flex: 1), Expanded(flex: 6, child: Text("Forced Left Results", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left)), const Spacer(flex: 6)]),
            Expanded(flex: 2, child: ResultsChartLCons(data))])
            .followedBy(correct_and_wrong())
            .followedBy([Spacer(flex: 1)])
            .followedBy([Padding(padding: const EdgeInsets.only(top: 15), child: submit(context, screenHeight, screenWidth))]).toList()

      )
    )
  );
  }

  Iterable<Widget> correct_and_wrong() {
    return spacify([
        [Icon(Icons.square, color: Colors.green), Text("% Correct", textAlign: TextAlign.justify)],
        [Icon(Icons.square, color: Colors.red), Text("% Error", textAlign: TextAlign.justify)],
      ]);
  }

  OutlinedButton submit(BuildContext context, double screenHeight, double screenWidth) {
    return OutlinedButton(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Submit Results"),
                content: const Text("You can contribute to our research by submitting your results to our global dichotic listening databas The transfer of your test results to our database is optional and depends on your consent. The size of the files is very small (< 2kb). Most importantly, the transferred file is completely anonymous. We use a secure file transfer protocol and password protected data storage on a university-owned server. The file cannot be traced to a particular iPhone ID. It includes the settings and test scores. We reserve the rights to use this information for statistical analyses and scientific publications. The average statistics of results received by us can be viewed at www.dichoticlistening.com.\n\nYou can read more about us at http://fmri.uib.no"),
                actions: [
                  TextButton(
                    onPressed: (){},
                    child: const Text("Submit"),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("Back")
                  )
                ],
              ),
            )},
      style: OutlinedButton.styleFrom(
    backgroundColor: Colors.white,
    elevation: 3,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
    child: Container(
      height: screenHeight*0.05,
      width: screenWidth*0.7,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
      Text("Submit results for our research",  style: Theme.of(context).textTheme.bodyMedium)
      ],)

  ));
  }
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
              },
            icon: const Icon(Icons.arrow_back_ios)
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),

      body: 
          Center(
            heightFactor: Checkbox.width,
            child:_pages(context).elementAt(_selectedIndex)),

            bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 45),
              label: 'Main Results'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline, size: 45),
              label: 'Details'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),


    );
  }

}