import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobial/chatbot/chatbot.dart';
import 'package:mobial/chatbot/speech_test.dart';
import 'package:mobial/pages/ticket_search/Ticket.dart';
import 'package:mobial/pages/car/car_service.dart';
import 'package:mobial/pages/custom_duty_search/custom_duty.dart';
import 'package:mobial/pages/points/qr_home.dart';
import 'package:mobial/pages/meet_chat/chat_home.dart';
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
    print(_pageController);
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) async {
    print(pageIndex);
    await _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 650),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          floatingActionButton: Chatbot(),
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
          body: Stack(
            children: [
              PageView(
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
                dragStartBehavior: DragStartBehavior.start,
              ),
              // Positioned(
              //     //left: 100.0,
              //     right: 50.0,
              //     bottom: 50.0,
              //     child: FloatingActionButton(
              //         onPressed: () => {
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => Chatbot()))
              //             }))
            ],
          )),
    );
  }
}
