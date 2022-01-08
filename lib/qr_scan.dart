import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobial/qr_home.dart';
import 'package:mobial/widgets/button_widget.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:mobial/widgets/progress.dart';

final LocalStorage storage = LocalStorage('mobial');

class QrScan extends StatefulWidget {
  QrScan({Key? key}) : super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  String qrCode = 'Unknown';
  String code = "";
  bool isError = false;
  bool isLoading = false;
  handleQrScan(String qrcode) async {
    setState(() {
      code = qrcode;
    });
    print("Scanned Code : $code");
    var url = Uri.parse("https://mobial.herokuapp.com/api/scan_qrcode");
    http.Response response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': storage.getItem('user')['email'],
          'id': code,
        }));
    print(response.statusCode);
    print(response.body);
    var data = jsonDecode(response.body);
    if (data != "QR Code Sucessfully Scanned") {
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QrHome(
                logInUser: storage.getItem('user')['email'],
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffd5e4e1),
        appBar: AppBar(
          backgroundColor: Color(0xff12928f),
          title: Text("QR Scan"),
        ),
        body: !isLoading
            ? (!isError
                ? (Center(
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
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 72),
                        ButtonWidget(
                          text: 'Start QR scan',
                          onClicked: () => scanQRCode(),
                        ),
                      ],
                    ),
                  ))
                : AlertDialog(
                    title: Text('Error while scanning Qr Code'),
                    content: Text('Either Invalid Qr Code or Already scanned'),
                    actions: [
                      ElevatedButton(
                          onPressed: () => {
                                setState(() {
                                  isError = false;
                                })
                              },
                          child: Text('Scan Again'))
                    ],
                  ))
            : circularProgress());
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
      print("After scan");
      print(qrCode);
      handleQrScan(qrCode);
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
