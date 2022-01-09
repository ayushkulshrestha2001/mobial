import 'dart:convert';
import 'package:mobial/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:mobial/pages/custom_duty_search/card.dart';
import 'package:mobial/pages/points/map.dart';
import 'package:mobial/pages/points/qr_scan.dart';
import 'package:mobial/pages/points/redeem_coupons.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final LocalStorage storage = LocalStorage('mobial');

class QrHome extends StatefulWidget {
  final String logInUser;
  QrHome({required this.logInUser});

  @override
  _QrHomeState createState() => _QrHomeState(logInUser: logInUser);
}

class _QrHomeState extends State<QrHome> {
  bool isLoading = false;
  final String logInUser;
  _QrHomeState({required this.logInUser});
  final LatLng bialLocation = new LatLng(77, 13);
  double latitude = 77.70;
  double longitude = 13.198;
  String name = "";
  num points = 0;
  List<dynamic> codes = [];
  List<Marker> markers = [];
  Map<String, Widget> popup = {};
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    print('After refresh');
    setState(() {
      isLoading = true;
    });
    var getUrl = Uri.parse("https://mobial.azurewebsites.net/api/get_qrcodes");
    http.Response markerResponse = await http.get(getUrl);
    var markerData = jsonDecode(markerResponse.body);
    setState(() {
      for (int i = 0; i < markerData.length; i++) {
        String latitude = markerData[i]['location'].split(', ').first;
        String longitude = markerData[i]['location'].split(', ').last;
        double lat = double.parse(latitude);
        double long = double.parse(longitude);
        setState(() {
          popup[markerData[i]['name']] = AlertDialog(
            title: Column(
              children: [
                Image(
                  image: NetworkImage(
                      "https://www.bengaluruairport.com/content/dam/bial/global/logo/bial-logo/KIAB-Logo-1200-X-628.jpg"),
                ),
                Text('${markerData[i]['name']}'),
              ],
            ),
          );

          markers.add(Marker(
            height: 80.0,
            width: 80.0,
            point: LatLng(lat, long),
            builder: (ctx) {
              return GestureDetector(
                child: Icon(
                  Icons.location_on,
                  size: 30.0,
                  color: Colors.black,
                ),
                onTap: () => {
                  showDialog(
                      context: ctx,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              Image(
                                image:
                                    NetworkImage('${markerData[i]['picture']}'),
                              ),
                              Text('${markerData[i]['name']}'),
                            ],
                          ),
                        );
                      })
                },
              );
            },
          ));
        });
      }
    });
    num rewards = 0;
    var url = Uri.parse("https://mobial.azurewebsites.net/api/userdata");
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
      String latitude = e['location'].split(', ').first;
      String longitude = e['location'].split(', ').last;
      double lat = double.parse(latitude);
      double long = double.parse(longitude);
      setState(() {
        markers.add(Marker(
            height: 80.0,
            width: 80.0,
            point: LatLng(lat, long),
            builder: (ctx) => Container(
                    child: Icon(
                  Icons.star,
                  size: 30.0,
                  color: Color(
                    0xffdaa520,
                  ),
                ))));
      });
    });
    print(rewards);
    setState(() {
      points = rewards;
      name = decodedData['name'];
      isLoading = false;
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffd5e4e1),
        appBar: header(context),
        drawer: drawer(context),
        body: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: () => getUserDetails(),
            child: !isLoading
                ? (Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
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
                                    foregroundColor:
                                        Theme.of(context).primaryColor,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(
                                        storage.getItem('user')['picture']),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "$name",
                                      style: GoogleFonts.signika(
                                          fontSize: 50.0,
                                          color: Color(0xffe5f7ff)),
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
                                    color: Color(0xfff9c508),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "$points",
                                    style: GoogleFonts.signika(
                                        fontSize: 40.0,
                                        color: Color(0xffe5f7ff)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RedeemCoupons()))
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QrScan()))
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapDisplay(
                                          markers: markers,
                                          popup: popup,
                                        )))
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
                    ],
                  ))
                : circularProgress()));
  }
}
