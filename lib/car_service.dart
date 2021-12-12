import 'package:flutter/material.dart';

class CarService extends StatefulWidget {
  CarService({Key? key}) : super(key: key);

  @override
  _CarServiceState createState() => _CarServiceState();
}

class _CarServiceState extends State<CarService> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Car-services page"),
    );
  }
}
