import 'package:flutter/material.dart';
import 'package:mobial/pages/ticket_search.dart/Ticket.dart';
import 'package:mobial/pages/car.dart/car_service.dart';
import 'package:mobial/pages/custom_duty_search.dart/custom_duty.dart';
import 'package:mobial/pages/points.dart/qr_home.dart';
import 'package:mobial/pages/meet_chat.dart/chat_home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  final String email;
  Home({required this.email});

  @override
  _HomeState createState() => _HomeState(email: email);
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
            CustomDuty(),
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
      ),
    );
  }
}
