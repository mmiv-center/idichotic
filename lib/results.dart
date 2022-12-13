// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/charts/resultschart.dart';
import 'package:dichotic/data/exampledata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:video_player/video_player.dart';

import 'data/types.dart';
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



class Results extends StatefulWidget {
  Results({super.key, required this.title, required this.data}) {
    rightCorrect = data.where((element) => element.id == Types.rightCorrect).toList();
    leftCorrect = data.where((element) => element.id == Types.leftCorrect).toList();
  }

  late List<Data> rightCorrect;
  late List<Data> leftCorrect;


  final List<Data> data;

  final String title;


  @override
  State<Results> createState() => _MyHomePageState(data:data);
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

Expanded details(double screenWidth, BuildContext context) {
  return Expanded(
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
  );
}

Iterable<Widget> spacify(List<List<Widget>> list) {
  return list.map<Widget>((e) {
    return Flexible(child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Spacer(flex: 2),
        Flexible(flex: 5, child: e[0]),
        Spacer(flex: 1),
        Flexible(flex: 10, child: e[1]),
        Spacer(flex: 10),
      ],
    ));
  });
}

class _MyHomePageState extends State<Results> {

  _MyHomePageState({required this.data});

  final List<Data> data;


  String brain_side = " ";
  String ear_side = " ";
  String side = " ";


  void initState(){

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {

      if(widget.rightCorrect[0].amount > widget.leftCorrect[0].amount){
        print(widget.rightCorrect);
        brain_side = L10n.of(context)!.brainLeft;
        ear_side = L10n.of(context)!.earLeft;
        side = L10n.of(context)!.sideSingle;
      }
      else if(widget.rightCorrect[0].amount == widget.leftCorrect[0].amount){
        print(widget.rightCorrect);
        brain_side = L10n.of(context)!.brainBoth;
        ear_side = L10n.of(context)!.earBoth;
        side = L10n.of(context)!.sidePlural;
      }
      else if(widget.rightCorrect[0].amount < widget.leftCorrect[0].amount){
        print(widget.rightCorrect);
        brain_side = L10n.of(context)!.brainRight;
        ear_side = L10n.of(context)!.earRight;
        side = L10n.of(context)!.sideSingle;
      }
      });
    });

  }

  List<Widget> _pages(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return <Widget> [
    results(screenWidth, context, screenHeight),

    details(screenWidth, context),

    animation(screenWidth, screenHeight)];

  }

  Center animation(double screenWidth, double screenHeight) {
    return Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [VideoPlayerExample(),
        Padding(padding: EdgeInsets.fromLTRB(screenWidth*0.05 ,screenHeight*0.05, screenWidth*0.05,0),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.square, color: Colors.red),
          Container(width: screenWidth*0.05),
          Text(L10n.of(context)!.soundProcessing, textAlign: TextAlign.center,)]))]),
  );
  }

  Expanded details(double screenWidth, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(screenWidth*0.05, 0, screenWidth*0.05, 0),
          child: Column(
          children: <Widget> [
          Text(L10n.of(context)!.learnDichotic, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left,),
          Text(L10n.of(context)!.dichoticParagraph),
          Text(L10n.of(context)!.reference, textAlign: TextAlign.left),
          Text(L10n.of(context)!.dichoticReferences)
        ],
    )
        ),
  )
);
  }

  Container results(double screenWidth, BuildContext context, double screenHeight) {
    return Container(
    alignment: Alignment.center,
    child:
    Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(screenWidth*0.04, 0, screenWidth*0.04, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Expanded(
            child:
            Text(L10n.of(context)!.wellDone,
              style: Theme.of(context).textTheme.titleLarge)),
          Expanded(
            child:
            Text(ear_side, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center)),
          Expanded(
            child:
          Text(brain_side, style: Theme.of(context).textTheme.headlineSmall)),
          Expanded(
            child:
            Text(side, style: Theme.of(context).textTheme.bodyMedium)),
          Expanded(flex: 1, child: ResultsChart(data))].followedBy(
          spacify(
          [
            [Icon(Icons.square, color: Colors.green), Text(L10n.of(context)!.prRight, textAlign: TextAlign.justify)],
            [Icon(Icons.square, color: Colors.red), Text(L10n.of(context)!.prError, textAlign: TextAlign.justify)],
            [Icon(Icons.square, color: Colors.blue), Text(L10n.of(context)!.prLeft, textAlign: TextAlign.justify)],
          ])
          ).toList().followedBy([
          Padding(padding: EdgeInsets.only(top: 15), child: submit(context, screenHeight, screenWidth))]).toList()
      )
    )
  );
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
                    onPressed: (){},
                    child:  Text(L10n.of(context)!.submit),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child:  Text(L10n.of(context)!.back)
                  )
                ],
              ),
            )},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
      ),
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

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart, size: 45),
              label: L10n.of(context)!.mainResults

          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.info_outline, size: 45),
              label: L10n.of(context)!.details
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.movie_creation_outlined, size: 45),
              label: L10n.of(context)!.animation
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),


    );
  }

}