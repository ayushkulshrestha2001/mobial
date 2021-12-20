import 'package:flutter/material.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';

class QrHome extends StatefulWidget {
  QrHome({Key? key}) : super(key: key);

  @override
  _QrHomeState createState() => _QrHomeState();
}

class _QrHomeState extends State<QrHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      drawer: drawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            margin: EdgeInsets.all(8.0),
            color: Colors.black12,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 50.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "USERNAME",
                        style: TextStyle(
                          fontSize: 50.0,
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
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "220",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
