import 'dart:convert';
import 'dart:developer';

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
            color: Colors.black12,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 50.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "$name",
                        style: TextStyle(
                          fontSize: 50.0,
                        ),
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
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "$points",
                        style: TextStyle(fontSize: 40.0),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
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
