import 'package:flutter/material.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';

class RenterInfo extends StatefulWidget {
  RenterInfo({Key? key}) : super(key: key);

  @override
  _RenterInfoState createState() => _RenterInfoState();
}

class _RenterInfoState extends State<RenterInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: header(context),
        drawer: drawer(context),
        body: Center(
          child: Text("Renter Info"),
        ),
      ),
    );
  }
}
