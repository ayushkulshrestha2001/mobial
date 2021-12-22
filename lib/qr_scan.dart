import 'package:flutter/material.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobial/widgets/button_widget.dart';

// class QrScan extends StatefulWidget {
//   QrScan({Key? key}) : super(key: key);

//   @override
//   _QrScanState createState() => _QrScanState();
// }

// class _QrScanState extends State<QrScan> {
//   String result = "Hello World...!";
//   Future _scanQR() async {
//     try {
//       String? cameraScanResult = await scanner.scan();
//       setState(() {
//         result =
//             cameraScanResult!; // setting string result with cameraScanResult
//       });
//     } on PlatformException catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("QR Scanner Example In Flutter"),
//       ),
//       body: Center(
//         child: Text(result), // Here the scanned result will be shown
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           icon: Icon(Icons.camera_alt),
//           onPressed: () {
//             _scanQR(); // calling a function when user click on button
//           },
//           label: Text("Scan")),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

class QrScan extends StatefulWidget {
  QrScan({Key? key}) : super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  String qrCode = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '$qrCode',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
