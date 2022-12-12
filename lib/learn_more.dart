// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class LearnMore extends StatefulWidget {

    @override
    State<StatefulWidget> createState() => LearnMoreState();
}


class LearnMoreState extends State<LearnMore> {

  
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: Text(L10n.of(context)!.learnDichotic , style: TextStyle(color: Colors.black)), 
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.fromLTRB(screenWidth*0.05, 0, screenWidth*0.05, 0),
            child: Column(  
            children: <Widget> [
            Text(L10n.of(context)!.dichoticParagraph),
            Text(L10n.of(context)!.reference, textAlign: TextAlign.left),
            Text(L10n.of(context)!.dichoticReferences)
          ],
      )
          ),
    )
    );
    throw UnimplementedError();
  }
}