import 'package:flutter/material.dart';
import 'package:mobial/widgets/header.dart';

class LendCarList extends StatefulWidget {
  LendCarList({Key? key}) : super(key: key);

  @override
  _LendCarListState createState() => _LendCarListState();
}

class _LendCarListState extends State<LendCarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: Center(
        child: Text("Previous Cars"),
      ),
    );
  }
}
