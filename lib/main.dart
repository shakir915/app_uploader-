import 'dart:convert';


import 'package:app_uploader/downloadScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'utils.dart';

Future<void> main() async {

  String myurl = Uri.base.toString(); //get complete url
  print("myurl $myurl");
  await fireBaseInitializeApp();



  runApp( MyApp(myurl));
}

class MyApp extends StatelessWidget {
  final String? myurl;
  const MyApp(this.myurl, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EW .',
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
      ),
      home:  DownloadScreen(myurl),
    );
  }
}




