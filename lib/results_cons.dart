// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/data/exampledata.dart';
import 'package:dichotic/data/types.dart';
import 'package:dichotic/charts/resultschart_cons_right.dart';
import 'package:dichotic/charts/resultschart_cons_left.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:charts_flutter/flutter.dart' as charts;
/*
class Results extends StatelessWidget {
  const Results({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

      ),
      home: const MyHomePage(title: 'Results'),
    );
  }
}*/

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
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return <Widget> [
    Center(
      child: 
      Container(
        padding: EdgeInsets.fromLTRB(screenWidth*0.04, 0, screenWidth*0.04, 0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:screenHeight*0.0),
              child: 
              Text("Well done!", 
                style: Theme.of(context).textTheme.titleLarge)),
            Padding(
              padding: EdgeInsets.fromLTRB(screenHeight*0.03, screenWidth*0.075, screenWidth*0.075, 0 ),
              child:
              Text("You were correct 75.5% of the time", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center)),
            Padding(
              padding: EdgeInsets.fromLTRB(0,screenHeight*0.03,0,0),
              child: 
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ResultsChartRCons(data)])),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: ResultsChartLCons(data)),
            Padding(
              padding: EdgeInsets.fromLTRB(0,screenHeight*0.37,0,0),
              child: 
            OutlinedButton(
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
            
      )))
          ],
        )
      )
    ),

    Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.fromLTRB(screenWidth*0.05, 0, screenWidth*0.05, 0),
            child: Column(  
            children: <Widget> [
            Text("Read more about dichotic listening \n", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left,),
            Text("The beginnings of the dichotic listening technique can be traced back to the 1950s and Donald Broadbent, who was interested in testing auditory attention abilities in air traffic controllers. \n \nAbout 10 years later, Doreen Kimura (1961a, 1961b) modified the paradigm and used spoken digits, which were presented simultaneously via headphones, one to each ear, to investigate language lateralization in patients with epilepsy and healthy subjects. The results showed that in both cases subjects with left hemisphere language processing recalled more items from the right ear, yielding what is called the right ear advantage. Subjects with language functions lateralized to the right hemisphere showed a tendency to report items presented to the left ear, yielding a left ear advantage. These findings have been replicated by numerous scientific studies (Hugdahl, 2003; Bryden, 1988). \n \nMore recently, Kenneth Hugdahl and colleagues have developed a consonant-vowel version of the dichotic listening paradigm (Hugdahl & Andersson, 1986), which is the basis of this iDichotic App. There are a few theoretical models that attempt to explain the common bias to report the right ear stimulus. The most widely accepted one goes back to Kimura (1967) and is called the structural model. It is based on the observation that each ear is predominantly connected to the opposite (contralateral) side of the brain (see Rosenzweig, 1951). \n \nAs a result, the stimulus played to the right ear will be more strongly represented in the contralateral left hemisphere, which in most individuals is the hemisphere which processes speech and language (Tervaniemi & Hugdahl, 2003; Frost el al., 1999; Loring et al., 1990). However, stimuli presented to the left ear will first be transferred to the right hemisphere. Since the right hemisphere is not able to fully process speech, the incoming information needs to be transferred to the left hemisphere in order to get processed. The resulting in a delayed processing of the left-ear as compared to the right-ear stimulus is thought to explain the right-ear preference in dichotic listening."),
            Text("\nReferences:\n", textAlign: TextAlign.left),
            Text("Broadbent, D. E. (1954). The role of auditory localization in attention and memory span. Journal of experimental psychology, 47(3), 191-196. \n\nBryden, M. P. (1988). An overview of the dichotic listening procedure and its relation to cerebral organization. \n\nIn K. Hugdahl (Ed.), Handbook of dichotic listening: Theory, methods and research (pp.1-43). Chichester, England: Wiley. \n\nFrost, J. A., Binder, J. R., Springer, J. A., Hammeke, T. A., Bellgowan, P. S., Rao, S. M., & Cox, R.W. (1999). Language processing is strongly left lateralized in both sexes. Evidence from functional MRI. Brain, 122(2), 199-208.\n\nHugdahl, K., & Andersson, L. (1986). The \"forced-attention paradigm\" in dichotic listening to CV-syllables: a comparison between adults and children. Cortex, 22(3), 417-432. \n\nHugdahl, K. (2003). Dichotic listening in the study of auditory laterality. \n\nIn K. Hugdahl & R. J. Davidson (Eds.), The asymmetrical brain. Cambridge, Mass.: MIT Press. Kimura, D. (1961a). Cerebral dominance and the perception of verbal stimuli. Canadian journal of psychology, 15(3), 166-171. \n\nKimura, D. (1961b). Some effects of temporal-lobe damage on auditory perception. Canadian journal of psychology, 15, 156-165. \n\nLoring, D. W., Meador, K. J., Lee, G. P., Murro, A. M., Smith, J. R., Flanigin, H. F., Gallagher, B. B., & King, D. W. (1990). Cerebral language lateralization: evidence from intracarotid amobarbital testing. Neuropsychologia, 28(8), 831-838. \n\nRosenzweig, M. R. (1951). Representations of the two ears at the auditory cortex. American journal of physiology, 167(1), 147.\n\nTervaniemi, M. & Hugdahl, K. (2003). Lateralization of auditory-cortex functions. Brain Research Reviews, 43, 231-246.")
          ],
      )
          ),
    )
  )];

  }
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override

  Widget build(BuildContext context) {
      
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      //extendBodyBehindAppBar: true,

      appBar: AppBar(
        //title: Text(widget.title),
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