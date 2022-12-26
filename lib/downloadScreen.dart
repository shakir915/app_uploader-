import 'dart:io';

import 'package:app_uploader/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadScreen extends StatefulWidget {
  final String? myurl;

  const DownloadScreen(this.myurl, {Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  String? iosURL;
  String? androidURL;
  String log="";

  @override
  void initState() {
    fireStoreRead(widget.myurl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Download"),
      ),
      body: Column(
        children: [
          InkWell(
              onTap: () {
                fireStoreRead(widget.myurl);
              },
              child: Text("Download")),

          Text(log)
        ],
      ),
    );
  }

  Future<void> fireStoreRead(String? myurl) async {
    try {
      var a = myurl?.split("/").last;

      log+="\n$a";

      var db = FirebaseFirestore.instance;

      final docRef = db.collection("ew").doc("2022_12_24_15_58_00_000");
      docRef.get().then(
        (DocumentSnapshot doc) async {
          final data = doc.data() as Map<String, dynamic>;
          iosURL = data["ios"];
          androidURL = data["android"];

          log+="\n$iosURL";
          log+="\n$androidURL";

          print("iosURL $iosURL");
          print("androidURL $androidURL");

          final storageRef = FirebaseStorage.instance.ref();

          final pathReference = storageRef.child("everything_women.ipa");
          print("pathReference $pathReference");
          final ipaURL = await pathReference.getDownloadURL();
          print("imageUrl $ipaURL");
          log+="\n$ipaURL";
          final mountainImagesRef = storageRef
              .child("${DateTime.now().millisecondsSinceEpoch}/manifest.plist");

          try {
            var s = ipaURL;
            var i = 0;
            while (i < 100) {
              s += DateTime.now().millisecondsSinceEpoch.toString();
            }

            log+="\n$s";

            await mountainImagesRef.putBlob(s);
          } catch (e) {
            print(e);
            log+="\n$e";
            // ...
          }

          var plistL = await mountainImagesRef.getDownloadURL();

          print("plistL $plistL");

          log+="\n$plistL";


          // ...
        },
        onError: (e) {
          print("Error getting document: $e");
          log+="\n$e";
          setState(() {

          });
        },
      );

//       // Create a new user with a first and last name
//       final user = <String, dynamic>{
//             "first": "Ada",
//             "last": "Lovelace",
//             "born": 1815
//           };
//
// // Add a new document with a generated ID
//       db.collection("users").add(user).then((DocumentReference doc) =>
//               print('DocumentSnapshot added with ID: ${doc.id}'));
//
//
//       // Create a new user with a first and last name
//       final user2 = <String, dynamic>{
//             "first": "Alan",
//             "middle": "Mathison",
//             "last": "Turing",
//             "born": 1912
//           };
//
// // Add a new document with a generated ID
//       db.collection("users").add(user2).then((DocumentReference doc) =>
//               print('DocumentSnapshot added with ID: ${doc.id}'));
    } catch (e) {
      print(e);

      log+="\n$e";
      setState(() {

      });
    }

    setState(() {

    });
  }
}
