import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// const spinkit = SpinKitRotatingCircle(
//   color: Colors.white,
//   size: 50.0,
// );

final spinkit = SpinKitSpinningLines(
  color: Colors.black,
);
Container circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 10.0),
    child: SpinKitSpinningLines(
      color: Colors.black,
    ),
  );
}

Container linearProgress() {
  return Container(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.purple),
    ),
  );
}
