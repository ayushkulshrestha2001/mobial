import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:mobial/car_info.dart';

class RenterInfo extends StatefulWidget {
  RenterInfo({Key? key}) : super(key: key);

  @override
  _RenterInfoState createState() => _RenterInfoState();
}

class _RenterInfoState extends State<RenterInfo> {
  String value = "Mini/Hitchback";
  final double _borderRadius = 24;
  var items = [
    PlaceInfo('Dubai Mall Food Court', Colors.black, Colors.white, 120,
        'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids'),
    PlaceInfo('Hamriyah Food Court', Color(0xffFFB157), Color(0xffFFA057), 120,
        'Sharjah', 'All you can eat · Casual · Groups'),
    PlaceInfo('Gate of Food Court', Color(0xffFF5B95), Color(0xffF8556D), 120,
        'Dubai · Near Dubai Aquarium', 'Casual · Groups'),
    PlaceInfo('Express Food Court', Color(0xffD76EF5), Color(0xff8F7AFE), 120,
        'Dubai', 'Casual · Good for kids · Delivery'),
    PlaceInfo('BurJuman Food Court', Color(0xff42E695), Color(0xff3BB2B8), 120,
        'Dubai · In BurJuman', '...'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildFilterBar(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarDetail(
                                  title: "WagonR",
                                  price: 1000,
                                  color: "white",
                                  gearbox: "Manual",
                                  fuel: "Petrol",
                                  brand: "MAryti Suzuki",
                                  path: "assets/img/login_logo.png",
                                ))),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        color: Color(0xff393e46),
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
                            'assets/icon.png',
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
                                items[index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                items[index].category,
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
                                      items[index].location,
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
                                items[index].rating.toString(),
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

  PreferredSize buildFilterBar() {
    String VehicleType = "Mini/Hitchback";
    String Time = "2 days";
    return PreferredSize(
      preferredSize: Size.fromHeight(70.0),
      child: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                DropdownButton<String>(
                  value: VehicleType,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.grey,
                  ),
                  elevation: 16,
                  style: const TextStyle(color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      VehicleType = newValue!;
                    });
                  },
                  items: <String>[
                    'Mini/Hitchback',
                    'Sedan',
                    'SUV',
                    'Two-wheeler'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  width: 30.0,
                ),
                DropdownButton<String>(
                  value: Time,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.grey,
                  ),
                  elevation: 16,
                  style: const TextStyle(color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      Time = newValue!;
                    });
                  },
                  items: <String>[
                    '2 days',
                    '5 days',
                    '1 week',
                    '2 weeks',
                    '1 month',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Row(
            //   children: [
            //     DropdownButton<String>(
            //       value: value,
            //       icon: const Icon(
            //         Icons.arrow_downward,
            //         color: Colors.grey,
            //       ),
            //       elevation: 16,
            //       style: const TextStyle(color: Colors.grey),
            //       onChanged: (String? newValue) {
            //         setState(() {
            //           value = newValue!;
            //         });
            //       },
            //       items: <String>[
            //         'Mini/Hitchback',
            //         'Sedan',
            //         'SUV',
            //         'Two-wheeler'
            //       ].map<DropdownMenuItem<String>>((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //     ),
            //     SizedBox(
            //       width: 20.0,
            //     ),
            //     DropdownButton<String>(
            //       value: value,
            //       icon: const Icon(
            //         Icons.arrow_downward,
            //         color: Colors.grey,
            //       ),
            //       elevation: 16,
            //       style: const TextStyle(color: Colors.grey),
            //       onChanged: (String? newValue) {
            //         setState(() {
            //           value = newValue!;
            //         });
            //       },
            //       items: <String>[
            //         'Mini/Hitchback',
            //         'Sedan',
            //         'SUV',
            //         'Two-wheeler'
            //       ].map<DropdownMenuItem<String>>((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
// DropdownButton<String>(
//             value: value,
//             icon: const Icon(
//               Icons.arrow_downward,
//               color: Colors.grey,
//             ),
//             elevation: 16,
//             style: const TextStyle(color: Colors.grey),
//             onChanged: (String? newValue) {
//               setState(() {
//                 value = newValue!;
//               });
//             },
//             items: <String>['Mini/Hitchback', 'Sedan', 'SUV', 'Two-wheeler']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//           DropdownButton<String>(
//             value: value,
//             icon: const Icon(
//               Icons.arrow_downward,
//               color: Colors.grey,
//             ),
//             elevation: 16,
//             style: const TextStyle(color: Colors.grey),
//             onChanged: (String? newValue) {
//               setState(() {
//                 value = newValue!;
//               });
//             },
//             items: <String>['Mini/Hitchback', 'Sedan', 'SUV', 'Two-wheeler']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),

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
