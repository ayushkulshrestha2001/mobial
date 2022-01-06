import 'package:flutter/material.dart';
import 'package:mobial/rentee_info.dart';
import 'package:mobial/renter_info.dart';
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
                    MaterialPageRoute(builder: (context) => RenterInfo()))
                // print("Renter Info")
              },
              child: Column(
                children: [
                  Text(
                    "Rent a Car",
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
                    MaterialPageRoute(builder: (context) => RenteeInfo()))
                //print("Rentee Info")
              },
              child: Column(
                children: [
                  Text(
                    "lend a Car",
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

////Rentee function////
// Text("vehicle type"),
// Text("Sudcategory"),
// Text("brand"),
// Text("name/model"),
// Text("avalaibility"),
// Text("Charges: /day or /hr"),
// Text("vehicle number"),
// Text("desp"),

////Renter funtion////
// Text("vehicle type: car/ two wheeler"),
// Text("Sudcategory"),
// Text("need"),
// Text("Charges: /day or /hr"),
// Text(""),

////Car select////
//button to rent

//picture
//desp
//name/model
//charges
//owner name
//vehicle number

////when renting the car////
//date of renting and retruning
//time
//upload your id
//