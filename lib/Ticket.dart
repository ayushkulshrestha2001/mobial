import 'package:flutter/material.dart';
import 'package:mobial/ticket_info.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  int _selectedIndex = 0;
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TicketInfo(ticketNumber: text_controller.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      drawer: drawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                labelText: 'Enter your Ticket Number',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
