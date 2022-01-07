import 'package:flutter/material.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';

class RentCarList extends StatefulWidget {
  RentCarList({Key? key}) : super(key: key);

  @override
  _RentCarListState createState() => _RentCarListState();
}

class _RentCarListState extends State<RentCarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      drawer: drawer(context),
      body: Center(
        child: Text("rent car list"),
      ),
    );
  }
}
