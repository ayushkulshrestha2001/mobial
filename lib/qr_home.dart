import 'package:flutter/material.dart';
import 'package:mobial/card.dart';
import 'package:mobial/map.dart';
import 'package:mobial/qr_scan.dart';
import 'package:mobial/redeem_coupons.dart';
import 'package:mobial/redeemed_coupons.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'package:latlong2/latlong.dart';

class QrHome extends StatefulWidget {
  QrHome({Key? key}) : super(key: key);

  @override
  _QrHomeState createState() => _QrHomeState();
}

class _QrHomeState extends State<QrHome> {
  final double _borderRadius = 24;
  final LatLng bialLocation = new LatLng(77, 13);
  double latitude = 77.70;
  double longitude = 13.198;
  @override
  void initState() {
    //bialLocation = LatLng(latitude, longitude);
    super.initState();
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
                        "USERNAME",
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
                        "220",
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
                    context, MaterialPageRoute(builder: (context) => Card5()))
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
