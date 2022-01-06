import 'package:flutter/material.dart';
import 'package:mobial/home.dart';
import 'package:mobial/landing.dart';
import 'package:mobial/login9/ui/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore_example/firebase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoBIAL',
      theme: ThemeData(
        backgroundColor: Color(0xffd5e4e1),
        colorScheme: ColorScheme.light(),
      ),
      // home: Home(
      //   email: 'vulcan@gmail.com',
      // ),
      home: Login9(),
    );
  }
}
