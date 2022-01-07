import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobial/rent_car_list.dart';
import 'package:mobial/rent_request_list.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';

class RentOptions extends StatefulWidget {
  RentOptions({Key? key}) : super(key: key);

  @override
  _RentOptionsState createState() => _RentOptionsState();
}

class _RentOptionsState extends State<RentOptions> {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RentRequestList()))
                // print("Renter Info")
              },
              child: Column(
                children: [
                  Text(
                    "Requests",
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
                    MaterialPageRoute(builder: (context) => RentCarList()))
                //print("Rentee Info")
              },
              child: Column(
                children: [
                  Text(
                    "Search a Car",
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
