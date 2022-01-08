import 'package:flutter/material.dart';
import 'package:mobial/pages/car.dart/lend_options.dart';
import 'package:mobial/pages/car.dart/rent_option.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'package:google_fonts/google_fonts.dart';

class CarService extends StatefulWidget {
  CarService({Key? key}) : super(key: key);

  @override
  _CarServiceState createState() => _CarServiceState();
}

class _CarServiceState extends State<CarService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: header(context),
      drawer: drawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: TextButton(
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RentOptions()))
                // print("Renter Info")
              },
              child: Column(
                children: [
                  Text(
                    "RENT",
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
                    MaterialPageRoute(builder: (context) => LendOptions()))
              },
              child: Column(
                children: [
                  Text(
                    "LEND",
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
