// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TicketInfo extends StatefulWidget {
  String cityDept;
  String cityArr;
  String status;
  String flight;
  String iata;
  String dept;
  String arr;
  String duration;
  String airArr;
  String airDept;
  TicketInfo(
      {required this.airDept,
      required this.airArr,
      required this.cityDept,
      required this.cityArr,
      required this.status,
      required this.flight,
      required this.iata,
      required this.dept,
      required this.arr,
      required this.duration});

  @override
  _TicketInfoState createState() => _TicketInfoState(
        cityDept: cityDept,
        cityArr: cityArr,
        status: status,
        iata: iata,
        flight: flight,
        Dept: dept,
        Arr: arr,
        duration: duration,
        airDept: airDept,
        airArr: airArr,
      );
}

class _TicketInfoState extends State<TicketInfo> {
  String cityDept;
  String cityArr;
  String Dept;
  String Arr;
  String status;
  String flight;
  String iata;
  String airDept;
  String airArr;
  String duration;

  _TicketInfoState(
      {required this.airDept,
      required this.airArr,
      required this.Dept,
      required this.status,
      required this.flight,
      required this.iata,
      required this.Arr,
      required this.cityDept,
      required this.cityArr,
      required this.duration});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff12928f),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("FLIGHT INFO"),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Color(0xff12928f),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
              height: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 7.0,
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xfff7f9ff)),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 150.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff12928f), Color(0xfff7f9ff)],
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "$Dept",
                                    style: GoogleFonts.signika(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "$airDept",
                                    style: GoogleFonts.signika(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "$cityDept",
                                    style: GoogleFonts.signika(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.airplanemode_active,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                  Text(
                                    "$duration",
                                    style: GoogleFonts.signika(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Status: $status",
                                    style: GoogleFonts.signika(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "IATA: $iata",
                                    style: GoogleFonts.signika(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Flight: $flight",
                                    style: GoogleFonts.signika(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "$Arr",
                                    style: GoogleFonts.signika(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "$airArr",
                                    style: GoogleFonts.signika(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "$cityArr",
                                    style: GoogleFonts.signika(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
