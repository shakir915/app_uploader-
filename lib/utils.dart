
import 'dart:html' as html;

import 'package:app_uploader/firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> fireBaseInitializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> getDownloadLink() async {

  final storage = FirebaseStorage.instance;
  print("storage $storage");
  final storageRef = FirebaseStorage.instance.ref();
  print("storageRef $storageRef");

  final pathReference = storageRef.child("everything_women.ipa");
  print("pathReference $pathReference");
  final imageUrl = await pathReference.getDownloadURL();
  print("imageUrl $imageUrl");

  downloadFile(imageUrl);
}

void downloadFile(String url) {
  html.AnchorElement anchorElement = new html.AnchorElement(href: url);
  anchorElement.download = url;
  anchorElement.click();

  print("imageUrl $url");
}


