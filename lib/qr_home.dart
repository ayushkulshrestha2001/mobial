import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobial/card.dart';
import 'package:mobial/map.dart';
import 'package:mobial/qr_scan.dart';
import 'package:mobial/redeem_coupons.dart';
import 'package:mobial/redeemed_coupons.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';

final LocalStorage storage = LocalStorage('mobial');

class QrHome extends StatefulWidget {
  final String logInUser;
  QrHome({required this.logInUser});

  @override
  _QrHomeState createState() => _QrHomeState(logInUser: logInUser);
}

class _QrHomeState extends State<QrHome> {
  final String logInUser;
  _QrHomeState({required this.logInUser});
  final double _borderRadius = 24;
  final LatLng bialLocation = new LatLng(77, 13);
  double latitude = 77.70;
  double longitude = 13.198;
  String name = "";
  num points = 0;
  List<dynamic> codes = [];
  @override
  void initState() {
    //bialLocation = LatLng(latitude, longitude);

    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    num rewards = 0;
    var url = Uri.parse("https://mobial.herokuapp.com/api/userdata");
    http.Response response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': logInUser,
        }));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var decodedData = jsonDecode(response.body);
    print(decodedData['qrcodes']);
    setState(() {
      codes = decodedData['qrcodes'];
    });
    codes.forEach((e) {
      rewards = rewards + e['reward'];
    });
    print(rewards);
    setState(() {
      points = rewards;
      name = decodedData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: header(context),
      drawer: drawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            margin: EdgeInsets.all(8.0),
            color: Color(0xff4255db),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        foregroundColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            NetworkImage(storage.getItem('user')['picture']),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "$name",
                        style: GoogleFonts.signika(
                            fontSize: 50.0, color: Color(0xffe5f7ff)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.api_rounded,
                        size: 40.0,
                        color: Color(0xfff9c508),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "$points",
                        style: GoogleFonts.signika(
                            fontSize: 40.0, color: Color(0xffe5f7ff)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            child: TextButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Card5(
                              codes: this.codes,
                            )))
              },
              child: Column(
                children: [
                  Text(
                    "History",
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
                    MaterialPageRoute(builder: (context) => RedeemCoupons()))
              },
              child: Column(
                children: [
                  Text(
                    "Redeem Coupons",
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
                    MaterialPageRoute(builder: (context) => RedeemedCoupons()))
              },
              child: Column(
                children: [
                  Text(
                    "Redeemed Coupons",
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => QrScan()))
              },
              child: Column(
                children: [
                  Text(
                    "Scan Qr Code",
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
                    MaterialPageRoute(builder: (context) => MapDisplay()))
              },
              child: Column(
                children: [
                  Text(
                    "map",
                    style: GoogleFonts.signika(
                        fontSize: 20.0,
                        color: Color(0xff30302e),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          //   Card(
          //     child: FlutterMap(
          //       options: new MapOptions(
          //         center: LatLng(latitude, longitude),
          //         zoom: 13.0,
          //       ),
          //       layers: [
          //         new TileLayerOptions(
          //           urlTemplate:
          //               "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          //           subdomains: ['a', 'b', 'c'],
          //           attributionBuilder: (_) {
          //             return Text("© MoBIAL");
          //           },
          //         ),
          //         MarkerLayerOptions(
          //           markers: [
          //             new Marker(
          //               width: 80.0,
          //               height: 80.0,
          //               point: LatLng(latitude, longitude),
          //               builder: (ctx) => Container(
          //                 child: FlutterLogo(),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  }
}
