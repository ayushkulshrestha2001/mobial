import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobial/ticket_info.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'package:date_field/date_field.dart';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
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

  getDetails() async {
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TicketInfo(details: response.body)));
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: header(context),
      drawer: drawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.025),
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: DateTimeFormField(
                decoration: const InputDecoration(
                  hintText: "Departure Time",
                  hintStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note, color: Colors.grey),
                  labelText: 'Departure Time',
                ),
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: text_controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: onSearch,
                  icon: Icon(Icons.search),
                ),
                border: UnderlineInputBorder(),
                labelText: 'Enter your Flight IATA Number',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
