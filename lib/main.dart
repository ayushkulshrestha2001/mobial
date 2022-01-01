import 'package:flutter/material.dart';
import 'package:mobial/home.dart';
import 'package:mobial/login9/ui/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoBIAL',
      theme: ThemeData(
          backgroundColor: Color(0xff1b262c), colorScheme: ColorScheme.dark()),
      home: Home(
        email: 'vulcan@gmail.com',
      ),
      //home: Login9(),
    );
  }
}
