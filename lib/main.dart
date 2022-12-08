// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/Start_Promt.dart';
import 'package:dichotic/db/database.dart';
import 'package:dichotic/settings/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'Start_Page.dart';
import 'site/configure_nonweb.dart' if (dart.library.html) 'site/configure_web.dart';

void main() {
  configureApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
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
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontFamily: 'Inter', color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontFamily: 'Inter', color: Colors.black, fontSize: 20),
          bodyMedium: TextStyle(fontFamily: 'Inter', color: Colors.black, fontSize: 16),
          bodySmall: TextStyle(fontFamily: 'Inter', color: Colors.black, fontSize: 12),
          headlineSmall: TextStyle(fontFamily: 'Inter', color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontFamily: 'Inter', color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)

        )
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var pageroute = () => MaterialPageRoute(builder: (context) => const Start_Promt(title: "Dichotic"));

  bool? startPrompt;

  @override
  void initState() {
    decideFirstScreen();

  }

  void decideFirstScreen() async {
    Preference? prefs = await database.select(database.preferences).getSingleOrNull();
    setState(() {
      startPrompt = isUnsetOrUnspecified(prefs);
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (kIsWeb) {
      var webWidget = handleWeb();
      if (webWidget != null) {
        return webWidget;
      }
    }

    if (startPrompt == null) {
      return const CircularProgressIndicator();
    }
    else if (startPrompt == true) {
      return const Start_Promt(title: "Dichotic");
    }
    else {
      return const StartApp(title: "Dichotic");
    }
  }
}
