import 'package:flutter/material.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  int _selectedIndex = 0;
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
    print('Hadoop');
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
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    print("helo");
                  },
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
