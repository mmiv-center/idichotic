// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';

class LearnMore extends StatefulWidget {

    @override
    State<StatefulWidget> createState() => LearnMoreState();
}

  final appBar = AppBar(
          title: const Text("Learn more about dichotic listening ", style: TextStyle(color: Colors.black)), 
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
        );

class LearnMoreState extends State<LearnMore> {

  
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.fromLTRB(screenWidth*0.05, 0, screenWidth*0.05, 0),
            child: Column(  
            children: <Widget> [
            Text("The beginnings of the dichotic listening technique can be traced back to the 1950s and Donald Broadbent, who was interested in testing auditory attention abilities in air traffic controllers. \n \nAbout 10 years later, Doreen Kimura (1961a, 1961b) modified the paradigm and used spoken digits, which were presented simultaneously via headphones, one to each ear, to investigate language lateralization in patients with epilepsy and healthy subjects. The results showed that in both cases subjects with left hemisphere language processing recalled more items from the right ear, yielding what is called the right ear advantage. Subjects with language functions lateralized to the right hemisphere showed a tendency to report items presented to the left ear, yielding a left ear advantage. These findings have been replicated by numerous scientific studies (Hugdahl, 2003; Bryden, 1988). \n \nMore recently, Kenneth Hugdahl and colleagues have developed a consonant-vowel version of the dichotic listening paradigm (Hugdahl & Andersson, 1986), which is the basis of this iDichotic App. There are a few theoretical models that attempt to explain the common bias to report the right ear stimulus. The most widely accepted one goes back to Kimura (1967) and is called the structural model. It is based on the observation that each ear is predominantly connected to the opposite (contralateral) side of the brain (see Rosenzweig, 1951). \n \nAs a result, the stimulus played to the right ear will be more strongly represented in the contralateral left hemisphere, which in most individuals is the hemisphere which processes speech and language (Tervaniemi & Hugdahl, 2003; Frost el al., 1999; Loring et al., 1990). However, stimuli presented to the left ear will first be transferred to the right hemisphere. Since the right hemisphere is not able to fully process speech, the incoming information needs to be transferred to the left hemisphere in order to get processed. The resulting in a delayed processing of the left-ear as compared to the right-ear stimulus is thought to explain the right-ear preference in dichotic listening."),
            Text("\nReferences:\n", textAlign: TextAlign.left),
            Text("Broadbent, D. E. (1954). The role of auditory localization in attention and memory span. Journal of experimental psychology, 47(3), 191-196. \n\nBryden, M. P. (1988). An overview of the dichotic listening procedure and its relation to cerebral organization. \n\nIn K. Hugdahl (Ed.), Handbook of dichotic listening: Theory, methods and research (pp.1-43). Chichester, England: Wiley. \n\nFrost, J. A., Binder, J. R., Springer, J. A., Hammeke, T. A., Bellgowan, P. S., Rao, S. M., & Cox, R.W. (1999). Language processing is strongly left lateralized in both sexes. Evidence from functional MRI. Brain, 122(2), 199-208.\n\nHugdahl, K., & Andersson, L. (1986). The \"forced-attention paradigm\" in dichotic listening to CV-syllables: a comparison between adults and children. Cortex, 22(3), 417-432. \n\nHugdahl, K. (2003). Dichotic listening in the study of auditory laterality. \n\nIn K. Hugdahl & R. J. Davidson (Eds.), The asymmetrical brain. Cambridge, Mass.: MIT Press. Kimura, D. (1961a). Cerebral dominance and the perception of verbal stimuli. Canadian journal of psychology, 15(3), 166-171. \n\nKimura, D. (1961b). Some effects of temporal-lobe damage on auditory perception. Canadian journal of psychology, 15, 156-165. \n\nLoring, D. W., Meador, K. J., Lee, G. P., Murro, A. M., Smith, J. R., Flanigin, H. F., Gallagher, B. B., & King, D. W. (1990). Cerebral language lateralization: evidence from intracarotid amobarbital testing. Neuropsychologia, 28(8), 831-838. \n\nRosenzweig, M. R. (1951). Representations of the two ears at the auditory cortex. American journal of physiology, 167(1), 147.\n\nTervaniemi, M. & Hugdahl, K. (2003). Lateralization of auditory-cortex functions. Brain Research Reviews, 43, 231-246.")
          ],
      )
          ),
    )
    );
    throw UnimplementedError();
  }
}