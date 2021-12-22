import 'package:flutter/material.dart';
import 'package:mobial/card.dart';
import 'package:mobial/qr_scan.dart';
import 'package:mobial/redeem_coupons.dart';
import 'package:mobial/redeemed_coupons.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'dart:ui' as ui;

class QrHome extends StatefulWidget {
  QrHome({Key? key}) : super(key: key);

  @override
  _QrHomeState createState() => _QrHomeState();
}

class _QrHomeState extends State<QrHome> {
  final double _borderRadius = 24;
  var items = [
    PlaceInfo('Dubai Mall Food Court', Color(0xff6DC8F3), Color(0xff73A1F9),
        4.4, 'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids'),
    PlaceInfo('Hamriyah Food Court', Color(0xffFFB157), Color(0xffFFA057), 3.7,
        'Sharjah', 'All you can eat · Casual · Groups'),
    PlaceInfo('Gate of Food Court', Color(0xffFF5B95), Color(0xffF8556D), 4.5,
        'Dubai · Near Dubai Aquarium', 'Casual · Groups'),
    PlaceInfo('Express Food Court', Color(0xffD76EF5), Color(0xff8F7AFE), 4.1,
        'Dubai', 'Casual · Good for kids · Delivery'),
    PlaceInfo('BurJuman Food Court', Color(0xff42E695), Color(0xff3BB2B8), 4.2,
        'Dubai · In BurJuman', '...'),
  ];
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
        ],
      ),
    );
  }
}

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
