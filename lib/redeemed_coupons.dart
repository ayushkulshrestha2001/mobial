import 'package:flutter/material.dart';

class RedeemedCoupons extends StatefulWidget {
  RedeemedCoupons({Key? key}) : super(key: key);

  @override
  _RedeemedCouponsState createState() => _RedeemedCouponsState();
}

class _RedeemedCouponsState extends State<RedeemedCoupons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Redeemed Coupons"),
    );
  }
}
