import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobial/pages/car.dart/lend_car_list.dart';
import 'package:mobial/pages/car.dart/post_car.dart';
import 'package:mobial/widgets/header.dart';

class LendOptions extends StatefulWidget {
  LendOptions({Key? key}) : super(key: key);

  @override
  _LendOptionsState createState() => _LendOptionsState();
}

class _LendOptionsState extends State<LendOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: header(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: TextButton(
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PostCar()))
                // print("Renter Info")
              },
              child: Column(
                children: [
                  Text(
                    "Post a Car",
                    style: GoogleFonts.signika(
                        fontSize: 20.0,
                        color: Color(0xff30302e),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: TextButton(
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LendCarList()))
                //print("Rentee Info")
              },
              child: Column(
                children: [
                  Text(
                    "Show previous Requests",
                    style: GoogleFonts.signika(
                        fontSize: 20.0,
                        color: Color(0xff30302e),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
