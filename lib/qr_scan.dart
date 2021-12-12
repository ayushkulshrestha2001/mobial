import 'package:flutter/material.dart';

class QRScan extends StatefulWidget {
  QRScan({Key? key}) : super(key: key);

  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("QR page"),
    );
  }
}
