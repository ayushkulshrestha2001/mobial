import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String body;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;

  const InfoCard({
    required this.title,
    this.body =
        """Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudi conseqr!""",
    this.subIcon = const CircleAvatar(
      child: Icon(
        Icons.money_outlined,
        color: Colors.white,
      ),
      backgroundColor: Colors.orange,
      radius: 25,
    ),
    this.subInfoText = "545 miles",
    this.subInfoTitle = "Custom Duty",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Container(
          padding: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  offset: Offset(0, 10),
                  blurRadius: 0,
                  spreadRadius: 0,
                )
              ],
              gradient: RadialGradient(
                colors: [Colors.black87, Colors.black87],
                focal: Alignment.topLeft,
                radius: 1,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                body,
                style: TextStyle(
                    color: Colors.white.withOpacity(.75), fontSize: 14),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      subIcon,
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subInfoTitle,
                            style: TextStyle(color: Colors.orange),
                          ),
                          Text(
                            subInfoText,
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
