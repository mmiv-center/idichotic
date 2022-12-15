// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:convert';
import 'dart:html';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:dichotic/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: Expanded(flex: 5, child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly, children: const [
              Expanded(child: Icon(Icons.warning, color: Colors.black)),
              Expanded(child: Text("Beta version", style: TextStyle(color: Colors.black),)),
            ],)),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            actions: [
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CupertinoButton(
                      onPressed: () {
                        window.history.pushState(null, 'iDichotic+', '/#');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage(
                                title: "iDichotic+",
                              ),
                            ));
                      },
                      color: Colors.green,
                      alignment: Alignment.topRight,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Text("Launch the app",
                          style: Theme.of(context).textTheme.bodyMedium)))
            ],
            bottom: const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: "Home"),
                Tab(text: "Feedback"),
                Tab(text: "QR Code Generator"),
              ],
            ),
            title: Expanded(
                flex: 1,
                child: Text('iDichotic+ Home Page',
                    style: Theme.of(context).textTheme.bodyLarge)),
          ),
          body: TabBarView(
            children: [home(context), feedback(), QrGenerator()],
          ),
        ));
  }

  Widget home(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Welcome to the iDichotic+ landing page",
            style: Theme.of(context).textTheme.bodyLarge),
        Spacer(flex: 1),
        Text(
            "iDichotic+ is an app that let's you discover which part of your brain processes language, and all you need is your headphones and a phone",
          style: Theme.of(context).textTheme.bodyLarge),
        Spacer(flex: 1),
        Text(
          "To try it out, simply click the Launch the app button in the top right corner",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Spacer(flex: 2),

        Expanded(flex: 1, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Spacer(flex: 8),
          Expanded(flex: 10, child: Linkify(text:
                  "Contribute or view the code on our GitHub https://github.com/mmiv-center/idichotic")),
          Expanded(flex: 1, child: Image(image: AssetImage('assets/logos/github.png'))),
          Spacer(flex: 8),
        ])),
        Expanded(flex: 1, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(flex: 8),
          const Expanded(flex: 10, child: Linkify(text:
                  "Help translate the app in your language! https://hosted.weblate.org/projects/idichotic/")),
          Expanded(flex: 1, child: SvgPicture.asset("assets/logos/weblate.svg")),
          Spacer(flex: 8)
        ])),
        footer()
      ],
    );
  }

  Widget footer() {
    return Flexible(
        flex: 3,
        child: Row(
            children: <Widget>[
          const Image(image: AssetImage('assets/logos/uib.png')),
          const Image(image: AssetImage('assets/logos/mmiv.png')),
          const Image(image: AssetImage('assets/logos/fmri.png'))
        ].map((e) => Expanded(child: e)).toList()));
  }

  Widget feedback() {
    return Column(
      children: [
        const Expanded(child: Icon(Icons.construction, size: 160)),
        const Expanded(child: Text("Under construction")),
        Expanded(
            child: Linkify(
          text:
              "In the mean time you can open an issue on our GitHub https://github.com//mmiv-center/idichotic/issues/new",
          onOpen: (link) async {
            if (await canLaunchUrl(Uri.parse(link.url))) {
              await launchUrl(Uri.parse(link.url));
            } else {
              throw 'Could not launch $link';
            }
          },
        ))
      ],
    );
  }

  ValueNotifier<String> server = ValueNotifier("");
  ValueNotifier<String> token = ValueNotifier("");

}

class QrGenerator extends StatefulWidget {
  ValueNotifier<String> result = ValueNotifier("");
  String token = "";
  String server = "";
  String user = "";

  @override
  State<StatefulWidget> createState() {
    return QrGeneratorState();
  }
}

class QrGeneratorState extends State<QrGenerator> {
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: widget.result,
    builder: (context, value, child) {
      return Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

        Expanded(child: Text("Under construction")),
        Expanded(
            child: Text(
                "The plan is for this page to generate a QR code, and a token, which you can then send to users you want data from")),
        Expanded(child: Text("Username")),
        Expanded(child: TextField(textAlign: TextAlign.center, onChanged: ((value) => widget.user = value),)),
        Expanded(child: Text("Server")),
        Expanded(child: TextField(textAlign: TextAlign.center, onChanged: ((value) => widget.server = value),)),
        Expanded(child: Text("Token")),
        Expanded(child: TextField(textAlign: TextAlign.center, onChanged: ((value) => widget.token = value),)),
        ElevatedButton(onPressed: () => generate(), child: Text(L10n.of(context)!.generate)),
        Expanded(child: SelectableText(widget.result.value))
      ]
    );
    }
    );
   }

  void generate() {
    widget.result.value = base64.encode(utf8.encode("${widget.user}::${widget.server}::${widget.token}"));
  }
}