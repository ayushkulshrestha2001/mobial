import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobial/ticket_info.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'package:date_field/date_field.dart';
import 'package:mobial/widgets/progress.dart';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  bool isLoading = false;
  int _selectedIndex = 0;
  DateTime time = DateTime.now();
  TextEditingController text_controller = TextEditingController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
    Text(
      'Index 4: Settings',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onSearch() {
    if (text_controller.text != "") {
      getDetails();
    }
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
  formatTime(DateTime d) => d.toString().split('.').first.padLeft(8, "0");

  getDetails() async {
    setState(() {
      isLoading = true;
    });
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss+00:00");
    String timeString = dateFormat.format(time);
    print(timeString);
    var url = Uri.parse("https://mobial.herokuapp.com/api/flight_info");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'flight': text_controller.text,
          'departure': timeString,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      DateTime dept = DateTime.parse(data["departure"]["estimated"]);
      DateTime arr = DateTime.parse(data["arrival"]["estimated"]);
      Duration dur = arr.difference(dept);
      String cityDept = data["departure"]["iata"];
      String cityArr = data["arrival"]["iata"];
      String airArr = data["arrival"]["airport"];
      String airDept = data["departure"]["airport"];
      String status = data["flight_status"];
      String flight = data["airline"]["name"];
      String iata = data["flight"]["iata"];
      print(formatTime(dept));
      setState(() {
        isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketInfo(
            cityDept: cityDept,
            cityArr: cityArr,
            Dept: formatTime(dept),
            Arr: formatTime(arr),
            airDept: airDept,
            airArr: airArr,
            duration: format(dur),
            status: status,
            flight: flight,
            iata: iata,
          ),
        ),
      );
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xffd5e4e1),
        appBar: header(context),
        drawer: drawer(context),
        body: !isLoading
            ? (Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 2.0),
                    child: Container(
                      width: size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: DateTimeFormField(
                        decoration: InputDecoration(
                            hintText: "Departure Time",
                            errorStyle: TextStyle(color: Colors.redAccent),
                            suffixIcon: Icon(Icons.event_note,
                                color: Colors.blueAccent),
                            labelText: 'Departure Time',
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(.75)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            )),
                        mode: DateTimeFieldPickerMode.dateAndTime,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) => (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null,
                        onDateSelected: (DateTime value) {
                          print(value);
                          setState(() {
                            time = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: const Offset(12, 26),
                              blurRadius: 50,
                              spreadRadius: 0,
                              color: Colors.grey.withOpacity(.1)),
                        ]),
                        child: TextFormField(
                          controller: text_controller,
                          onChanged: (value) {
                            //Do something wi
                          },
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.flight_takeoff,
                              color: Colors.blueAccent,
                            ),
                            suffixIcon: IconButton(
                                onPressed: onSearch, icon: Icon(Icons.search)),
                            filled: true,
                            hintText: 'Enter the IATA number',
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(.75)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                    child: Image(
                      image: AssetImage('assets/img/flight_info.png'),
                    ),
                  ),
                ],
              ))
            : circularProgress());
  }
}
