import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobial/Ticket.dart';
import 'package:mobial/car_service.dart';
import 'package:mobial/card.dart';
import 'package:mobial/custom_duty.dart';
//import 'package:mobial/qr_scan.dart';
import 'package:mobial/qr_home.dart';
import 'package:mobial/chat_home.dart';
//import 'package:mobial/qr_scan.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  final String email;
  Home({required this.email});

  @override
  _HomeState createState() => _HomeState(email: email);
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final String email;
  _HomeState({required this.email});
  @override
  void initState() {
    super.initState();
  }

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
      // bottomNavigationBar: CupertinoTabBar(
      //   backgroundColor: Color(0xffd5e4e1),
      //   currentIndex: pageIndex,
      //   onTap: onTap,
      //   activeColor: Colors.black,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.flight,
      //         color: Colors.black,
      //       ),
      //       label: 'Flight',
      //       backgroundColor: Colors.green,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.camera),
      //       label: 'Duty',
      //       backgroundColor: Colors.green,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.group),
      //       label: 'Meet',
      //       backgroundColor: Colors.green,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.directions_car),
      //       label: 'Services',
      //       backgroundColor: Colors.green,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.qr_code_scanner_rounded),
      //       label: 'Play',
      //       backgroundColor: Colors.green,
      //     ),
      //   ],
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.flight, size: 30),
          Icon(Icons.camera, size: 30),
          Icon(Icons.group, size: 30),
          Icon(Icons.directions_car, size: 30),
          Icon(Icons.qr_code_scanner_rounded, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Color(0xffd5e4e1),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: onTap,
        letIndexChange: (index) => true,
      ),
      body: PageView(
        children: [
          Ticket(),
          Custom_duty(),
          ChatHome(
            logInUser: email,
          ),
          CarService(),
          QrHome(
            logInUser: email,
          ),
        ],
        controller: _pageController,
        onPageChanged: onPageChange,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}


//8CCEC8