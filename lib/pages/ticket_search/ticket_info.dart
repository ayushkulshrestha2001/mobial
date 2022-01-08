// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mobial/values/global.dart';

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
        backgroundColor: blueColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("FLIGHT INFO"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    color: blueColor,
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
                        horizontal: 15.0, vertical: 100.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: [blueColor, Color(0xfff7f9ff)],
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
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subhead
                                    //     .apply(color: textColor ?? Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "$airDept",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subhead
                                    //     .apply(color: textColor ?? Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "$cityDept",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .title
                                    //     .apply(color: textColor ?? Colors.white, fontWeightDelta: 2),
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
                                  Icon(Icons.airplanemode_active,
                                      color: Colors.white),
                                  Text(
                                    "$duration",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subtitle
                                    //     .apply(color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Status: $status",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subhead
                                    //     .apply(color: textColor ?? Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "IATA: $iata",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subhead
                                    //     .apply(color: textColor ?? Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Flight: $flight",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subhead
                                    //     .apply(color: textColor ?? Colors.white),
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
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subhead
                                    //     .apply(color: textColor ?? Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "$airArr",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subhead
                                    //     .apply(color: textColor ?? Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "$cityArr",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .title
                                    //     .apply(color: textColor ?? Colors.white, fontWeightDelta: 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Container(
                        //   margin: EdgeInsets.symmetric(vertical: 15.0),
                        //   height: 100,
                        //   child: Stack(
                        //     children: <Widget>[
                        //       Positioned.fill(
                        //         child: Image.network(cloudImg),
                        //       ),
                        //       Positioned.fill(
                        //         child: Image.network(airplaneImg),
                        //       ),
                        //     ],
                        //   ),
                        // )
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

// Scaffold(
//       appBar: header(context),
//       drawer: drawer(context),
//       body: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               "$ticketInfo",
//               style: TextStyle(
//                 fontSize: 50.0,
//               ),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               "Date: 12-12-2021",
//               style: TextStyle(
//                 fontSize: 20.0,
//               ),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               "Time: 15:00",
//               style: TextStyle(
//                 fontSize: 20.0,
//               ),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Departure location"),
//                     Text("BIAL, Bangaluru"),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text("Destination"),
//                     Text("Dubai Airport"),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
