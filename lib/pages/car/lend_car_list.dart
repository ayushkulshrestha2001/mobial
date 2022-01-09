import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:mobial/widgets/progress.dart';

final LocalStorage storage = LocalStorage('mobial');

class LendCarList extends StatefulWidget {
  LendCarList({Key? key}) : super(key: key);

  @override
  _LendCarListState createState() => _LendCarListState();
}

class _LendCarListState extends State<LendCarList> {
  bool isLoading = false;
  List<PlaceInfo> cars = [];
  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("https://mobial.azurewebsites.net/api/previous_car");
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
            data[i]['picture'],
            data[i]['vehicle_name'],
            Colors.black,
            Colors.black,
            data[i]['expected_charge'] ?? '0',
            data[i]['vehicle_number'] ?? '223',
            data[i]['vehicle_type'] ?? 'car'));
      }
      isLoading = false;
    });
  }

  final double _borderRadius = 24;

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
      body: !isLoading
          ? (ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                            // onTap: () => {
                            //       Navigator.of(context).push(MaterialPageRoute(
                            //           builder: (context) => LendCarDetails(
                            //                 vehicleName: cars[index].name,
                            //                 price: cars[index].rating,
                            //                 vehicleNumber: cars[index].location,
                            //               )))
                            //     },
                            child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_borderRadius),
                            color: Color(0xff072227),
                          ),
                        )),
                        Positioned.fill(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: cars[index].picture != ""
                                    ? Image(
                                        image:
                                            NetworkImage(cars[index].picture),
                                        height: 64,
                                        width: 64,
                                      )
                                    : Image.asset('assests/img/car.png'),
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
            ))
          : circularProgress(),
    );
  }
}

class PlaceInfo {
  final String picture;
  final String name;
  final String category;
  final String location;
  final String rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.picture, this.name, this.startColor, this.endColor,
      this.rating, this.location, this.category);
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
