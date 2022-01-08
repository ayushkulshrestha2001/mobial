import 'package:flutter/material.dart';

class SpecificsCard extends StatelessWidget {
  final mainHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 30);

  final subHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  final basicHeading = TextStyle(fontSize: 15);
  final double? price;
  final String? name;
  final String? name2;

  SpecificsCard({this.price, this.name, this.name2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: price == null ? 80 : 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: price == null
          ? Column(
              children: [
                Text(
                  "$name",
                  style: basicHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "$name2",
                  style: subHeading,
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  "$name",
                  style: basicHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  price.toString(),
                  style: subHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("$name2")
              ],
            ),
    );
  }
}
