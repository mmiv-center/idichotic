// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/charts/resultschart_cons_left.dart';
import 'package:dichotic/charts/resultschart_cons_right.dart';
import 'package:dichotic/data/exampledata.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'data/types.dart';
import 'listen.dart';
import 'results.dart';

class ResultsCons extends StatefulWidget {
  ResultsCons({super.key, required this.title, required this.data}) {

    rightCorrect = data.where((element) => element.id == Types.rightCorrect).toList();
    leftCorrect = data.where((element) => element.id == Types.leftCorrect).toList();
  }

  late List<Data> rightCorrect;
  late List<Data> leftCorrect;


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


  double total_correct = 0;

  void initState(){

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {

        total_correct = ((widget.rightCorrect[0].amount + widget.leftCorrect[0].amount) / 60 * 100).roundToDouble() ;
 
      });
    });

  }

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
            Expanded(child: Text(L10n.of(context)!.wellDone, style: Theme.of(context).textTheme.titleLarge)),
            Expanded(child: Text(L10n.of(context)!.correct + "${total_correct}" + L10n.of(context)!.prTime, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left)),
            Row(children: [const Spacer(flex: 1), Expanded(flex: 6, child: Text(L10n.of(context)!.rightResults, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left)), const Spacer(flex: 6)]),
            Expanded(flex: 2, child: ResultsChartRCons(data))]
            .followedBy([
            Row(children: [const Spacer(flex: 1), Expanded(flex: 6, child: Text(L10n.of(context)!.leftResults, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left)), const Spacer(flex: 6)]),
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
        [Icon(Icons.square, color: Colors.green), Text(L10n.of(context)!.prCorrect, textAlign: TextAlign.justify)],
        [Icon(Icons.square, color: Colors.red), Text(L10n.of(context)!.prError, textAlign: TextAlign.justify)],
      ]);
  }

  OutlinedButton submit(BuildContext context, double screenHeight, double screenWidth) {
    return OutlinedButton(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(L10n.of(context)!.submitResults),
                content:  Text(L10n.of(context)!.contribute),
                actions: [
                  TextButton(
                    onPressed: (){showDialog(context: context, builder: (context) => 
                    AlertDialog( 
                    content: Container(

                      child: Text(L10n.of(context)!.resultsSuccesfully, textAlign: TextAlign.center,)),
                    actions: [TextButton(
                      onPressed: () {Navigator.pop(context);},
                      child: Text(L10n.of(context)!.ok, style: TextStyle(color: Colors.black) ),)
                                       
                      ]));},
                    child:  Text(L10n.of(context)!.submit, style: TextStyle(color: Colors.black) ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(L10n.of(context)!.back, style: TextStyle(color: Colors.black) )
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
      Text(L10n.of(context)!.submitResults,  style: Theme.of(context).textTheme.bodyMedium)
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

    
    var pageroute_tests = () => MaterialPageRoute(builder: (context) =>  TestApp(title: L10n.of(context)!.tests));
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, pageroute_tests());
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

        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 45),
              label: L10n.of(context)!.mainResults
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline, size: 45),
              label: L10n.of(context)!.details,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),


    );
  }

}