import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobial/pages/car/rent_car_info.dart';
import 'dart:ui' as ui;
import 'package:mobial/widgets/progress.dart';

class RentCarList extends StatefulWidget {
  RentCarList({Key? key}) : super(key: key);

  @override
  _RentCarListState createState() => _RentCarListState();
}

class _RentCarListState extends State<RentCarList> {
  List list = [];
  bool isLoading = false;
  getCarList() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("https://mobial.azurewebsites.net/api/active_car");
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    setState(() {
      list = jsonDecode(response.body);
      isLoading = false;
    });
  }

  void initState() {
    super.initState();
    getCarList();
  }

  final double _borderRadius = 24;

  void filter(String fil) {
    setState(() {
      isLoading = true;
    });
    List temp = list;
    setState(() {
      list = [];
    });
    for (int i = 0; i < temp.length; i++) {
      if (temp[i]["vehicle_type"] == fil) {
        list.add(temp[i]);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffd5e4e1),
        appBar: AppBar(
          backgroundColor: Color(0xff12928f),
          elevation: 0,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.filter_alt_outlined),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.car_rental_outlined),
                    title: Text('Sedan'),
                    onTap: () {
                      String fil = 'Sedan';
                      filter(fil);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.bike_scooter_outlined),
                    title: Text('Two wheelers'),
                    onTap: () {
                      String fil = 'Two-wheeler';
                      filter(fil);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.car_rental_outlined),
                    title: Text('SUV'),
                    onTap: () {
                      String fil = 'SUV';
                      filter(fil);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.car_rental_outlined),
                    title: Text('Mini/Hitchback'),
                    onTap: () {
                      String fil = 'Mini/Hitchback';
                      filter(fil);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.refresh),
                    title: Text('All vehicles'),
                    onTap: () {
                      getCarList();
                    },
                  ),
                ),
              ],
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text('Rent Car List'),
        ),
        body: !isLoading
            ? (ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          print(list.length);
                          return LendCarDetails(
                            id: list[index]['_id'],
                            // picture: list[index]["vehicle_picture"],
                            picture: list[index]['vehicle_picture'],
                            vehicleNumber: list[index]["vehicle_number"],
                            price: list[index]["expected_charge"],
                            renteeEmail: list[index]["rentee_email"],
                            vehicleName: list[index]["vehicle_name"],
                            vehicleType: list[index]["vehicle_type"],
                            description: list[index]["description"],
                            fromDate: list[index]["from_date"],
                            toDate: list[index]["to_date"],
                            path: "Hello",
                          );
                        },
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(_borderRadius),
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
                                    child: Image.network(
                                      list[index]["vehicle_picture"],
                                      height: 64,
                                      width: 64,
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          list[index]["vehicle_name"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          list[index]["description"],
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
                                                list[index]["vehicle_type"],
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
                                          list[index]["expected_charge"]
                                              .toString(),
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
                    ),
                  );
                },
              ))
            : circularProgress());
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
