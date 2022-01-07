import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:mobial/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = LocalStorage('mobial');

class LendCarList extends StatefulWidget {
  LendCarList({Key? key}) : super(key: key);

  @override
  _LendCarListState createState() => _LendCarListState();
}

class _LendCarListState extends State<LendCarList> {
  List<PlaceInfo> cars = [];
  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    var url = Uri.parse("https://mobial.herokuapp.com/api/previous_car");
    http.Response response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          "rentee": true,
          "rentee_email": storage.getItem('user')['email'],
        }));
    print(response.statusCode);
    print(response.body);
    var data = jsonDecode(response.body);
    setState(() {
      for (int i = 0; i < data.length; i++) {
        cars.add(PlaceInfo(
            data[i]['vehicle_name'],
            Colors.black,
            Colors.black,
            data[i]['expected_charge'] ?? '0',
            data[i]['vehicle_number'] ?? '223',
            data[i]['vehilce_type'] ?? 'car'));
      }
    });
  }

  final double _borderRadius = 24;

  // var items = [
  //   PlaceInfo('Sleeping Lounge', Colors.black, Colors.white, 30,
  //       'Bangalore · In BIAL', 'Cosy · Secure'),
  //   PlaceInfo('Baby Care Rooms', Color(0xffFFB157), Color(0xffFFA057), 40,
  //       'Bangalore · In BIAL', 'Joyous'),
  //   PlaceInfo('Smoking Lounge', Color(0xffFF5B95), Color(0xffF8556D), 100,
  //       'Bangalore · In BIAL', 'Casual'),
  //   PlaceInfo('Buggy Service', Color(0xffD76EF5), Color(0xff8F7AFE), 75,
  //       'Bangalore · In BIAL', 'Transport'),
  //   PlaceInfo('Taj Bangalore', Color(0xff42E695), Color(0xff3BB2B8), 200,
  //       'Bangalore', ' luxurious rooms · restaurants · banquet facilities'),
  //   PlaceInfo('080 Transit Hotel', Color(0xff42E695), Color(0xff3BB2B8), 250,
  //       'Bangalore', 'dream destination'),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: AppBar(
        backgroundColor: Color(0xff12928f),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Text('Lend Car List'),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_borderRadius),
                      color: Color(0xff072227),
                      // gradient: LinearGradient(colors: [
                      //   items[index].startColor,
                      //   items[index].endColor
                      // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: items[index].endColor,
                      //     blurRadius: 12,
                      //     offset: Offset(0, 6),
                      //   ),
                      // ],
                    ),
                  ),
                  // Positioned(
                  //   right: 0,
                  //   bottom: 0,
                  //   top: 0,
                  //   child: CustomPaint(
                  //     size: Size(100, 150),
                  //     painter: CustomCardShapePainter(_borderRadius,
                  //         items[index].startColor, items[index].endColor),
                  //   ),
                  // ),
                  Positioned.fill(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            'assets/img/bial_logo_bg.png',
                            height: 64,
                            width: 64,
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                cars[index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                cars[index].category,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir',
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      cars[index].location,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Avenir',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                cars[index].rating.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              //RatingBar(rating: items[index].rating),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final String rating;
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
