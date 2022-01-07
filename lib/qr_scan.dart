import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobial/widgets/button_widget.dart';
import 'package:http/http.dart' as http;

class QrScan extends StatefulWidget {
  QrScan({Key? key}) : super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  String qrCode = 'Unknown';
  handleQrScan() async {
    print("Qr code");
    setState(() {
      this.qrCode = qrCode;
    });
    var url = Uri.parse("https://mobial.herokuapp.com/api/scan_qrcode");
    http.Response response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': 'vulcan@gmail.com',
          'id': this.qrCode,
        }));
    print(response.statusCode);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: AppBar(
        backgroundColor: Color(0xff12928f),
        title: Text("QR Scan"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Scan Result',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xffd5e4e1),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '$qrCode',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xffd5e4e1),
              ),
            ),
            SizedBox(height: 72),
            ButtonWidget(
              text: 'Start QR scan',
              onClicked: () => scanQRCode(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;
      handleQrScan();
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
