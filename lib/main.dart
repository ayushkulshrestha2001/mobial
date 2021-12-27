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
      title: 'Flutter Demo',
      theme: ThemeData(
          backgroundColor: Color(0xff1b262c),
          // colorScheme: ColorScheme(
          //     primary: Color(0xff3282b8),
          //     primaryVariant: Color(0xff3282b8),
          //     secondary: Color(0xffbbe1fa),
          //     secondaryVariant: Color(0xffbbe1fa),
          //     surface: Color(0xff1b262c),
          //     background: Color(0xff1b262c),
          //     error: Colors.red,
          //     onPrimary: Color(0xff3282b8),
          //     onSecondary: Color(0xffbbe1fa),
          //     onSurface: Colors.white,
          //     onBackground: Color(0xff1b262c),
          //     onError: Colors.red,
          //     brightness: Brightness.dark),
          colorScheme: ColorScheme.dark()),
      // home: Home(
      //   email: 'sallyg@gmail.com',
      // ),
      home: Login9(),
    );
  }
}
