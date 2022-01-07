import 'package:flutter/material.dart';
import 'package:mobial/widgets/specific_card.dart';

class LendCarDetails extends StatelessWidget {
  final MainHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 30);

  final SubHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  final BasicHeading = TextStyle(fontSize: 15);
  final String? vehicle_name;
  final String? price;
  final String? rentee_email;
  final String? vehicle_number;
  final String? description;
  final String? vehicle_type;
  final String? path;

  LendCarDetails(
      {this.vehicle_name,
      this.price,
      this.rentee_email,
      this.vehicle_number,
      this.description,
      this.vehicle_type,
      this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.bookmark,
                  size: 30, color: Theme.of(context).accentColor)),
          IconButton(onPressed: null, icon: Icon(Icons.share, size: 30)),
        ],
      ),
      body: Column(
        children: [
          Text("$vehicle_name", style: MainHeading),
          Text(
            "$vehicle_type",
            style: BasicHeading,
          ),
          Hero(tag: "$vehicle_name", child: Image.asset("$path")),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     SpecificsCard(
          //       name: '12 Month',
          //       price: price! * 12,
          //       name2: 'Dollars',
          //     ),
          //     SpecificsCard(
          //       name: '6 Month',
          //       price: price! * 6,
          //       name2: 'Dollars',
          //     ),
          //     SpecificsCard(
          //       name: '1 Month',
          //       price: price! * 1,
          //       name2: 'Dollars',
          //     )
          //   ],
          // ),
          SizedBox(height: 20),
          Text(
            'SPECIFICATIONS',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SpecificsCard(
                name: 'Color',
                name2: rentee_email,
              ),
              SpecificsCard(
                name: 'Gearbox',
                name2: vehicle_number,
              ),
              SpecificsCard(
                name: 'Fuel',
                name2: description,
              )
            ],
          ),
        ],
      ),
    );
  }
}
