import 'package:flutter/material.dart';
import 'package:mobial/widgets/widgets.dart';
import 'package:mobial/global.dart';

class TicketInfo extends StatefulWidget {
  final String? ticketNumber;
  TicketInfo({this.ticketNumber});

  @override
  _TicketInfoState createState() => _TicketInfoState(ticketInfo: ticketNumber);
}

class _TicketInfoState extends State<TicketInfo> {
  final String? ticketInfo;
  _TicketInfoState({this.ticketInfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("BOARDING PASS"),
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
                        horizontal: 15.0, vertical: 25.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [blueColor, Color(0xfff7f9ff)],
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            FlightDetailColumn(),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.airplanemode_active,
                                      color: Colors.white),
                                  Text(
                                    "1h31min",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subtitle
                                    //     .apply(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            FlightDetailColumn(),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15.0),
                          height: 100,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Image.network(cloudImg),
                              ),
                              Positioned.fill(
                                child: Image.network(airplaneImg),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlightInfoRow(
                          title: "Flight",
                          content: "LF713",
                        ),
                      ),
                      Expanded(
                        child: FlightInfoRow(
                          title: "Class",
                          content: "First",
                        ),
                      ),
                      Expanded(
                        child: FlightInfoRow(
                          title: "Boarding",
                          content: "09:11",
                        ),
                      ),
                      Expanded(
                        child: FlightInfoRow(
                          title: "Terminal",
                          content: "12A",
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    padding: const EdgeInsets.all(15.0),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        PassengerContainer(
                          age: "21",
                          imageUrl:
                              "https://lh3.googleusercontent.com/-GELaWFBRPnQ/We3KfYBqTuI/AAAAAAAAAqE/wQDXxVI6nFoox1gOKfvIjmH1_5LKUhKzACEwYBhgL/w140-h140-p/20376010_1795833643775120_614181264397520443_n%2B%25281%2529.jpg",
                          fullName: "Amazigh Halzoun",
                          gender: "MALE",
                          seat: "18A",
                        ),
                        Divider(),
                        PassengerContainer(
                          age: "21",
                          imageUrl: userimageUrl,
                          fullName: "CYBDOM TECH",
                          gender: "MALE",
                          seat: "17A",
                        ),
                      ],
                    ),
                  ),
                  Image.network(boardingpassImg),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FlightInfoRow extends StatelessWidget {
  final String? title, content;

  const FlightInfoRow({this.title, this.content});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "$title",
          //style: Theme.of(context).textTheme.body1.apply(color: Colors.black45),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          "$content",
          //style: Theme.of(context).textTheme.title.apply(color: Colors.black87),
        )
      ],
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