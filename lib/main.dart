import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  Future testData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var data = await db.collection('event_details').get();
    var details = data.docs.toList();
    details.forEach((d) {
      print(d.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp().whenComplete(() {
      testData();
    });

    return MaterialApp(
      title: 'Events',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(),
    );
  }
}
