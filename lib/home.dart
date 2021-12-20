import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobial/Ticket.dart';
import 'package:mobial/car_service.dart';
import 'package:mobial/card.dart';
import 'package:mobial/custom_duty.dart';
import 'package:mobial/meet.dart';
import 'package:mobial/qr_scan.dart';
import 'package:mobial/qr_home.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController();
  int pageIndex = 0;
  void onPageChange(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) async {
    await _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Ticket(),
          Custom_duty(),
          ChatPage(),
          CarService(),
          QrHome(),
        ],
        controller: _pageController,
        onPageChanged: onPageChange,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Color(0xff0f4c75),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            label: 'Flight',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Duty',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Meet',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Services',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Play',
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
