import 'package:flutter/material.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';

class RentRequestList extends StatefulWidget {
  RentRequestList({Key? key}) : super(key: key);

  @override
  _RentRequestListState createState() => _RentRequestListState();
}

class _RentRequestListState extends State<RentRequestList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      drawer: drawer(context),
      body: Center(
        child: Text("Rent Request List"),
      ),
    );
  }
}
