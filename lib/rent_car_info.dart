import 'package:flutter/material.dart';
import 'package:mobial/renter_form.dart';
import 'package:mobial/widgets/specific_card.dart';

class LendCarDetails extends StatelessWidget {
  final MainHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 30);

  final SubHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  final BasicHeading = TextStyle(fontSize: 15);
  final String? id;
  final String? picture;
  final String? vehicle_name;
  final String? price;
  final String? fromDate;
  final String? toDate;
  final String? rentee_email;
  final String? vehicle_number;
  final String? description;
  final String? vehicle_type;
  final String? path;

  LendCarDetails(
      {this.id,
      this.vehicle_name,
      this.price,
      this.fromDate,
      this.toDate,
      this.rentee_email,
      this.vehicle_number,
      this.description,
      this.vehicle_type,
      this.path,
      this.picture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: AppBar(
        backgroundColor: Color(0xff12928f),
        title: Text('Vehicle Information'),
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RenterForm(id: id)))
                },
                child: Text('Book'),
              )),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("$vehicle_name", style: MainHeading),
              Text(
                "$vehicle_type",
                style: BasicHeading,
              ),
              Hero(
                tag: "$vehicle_name",
                child: Image.asset(
                  "assets/img/car.png",
                  height: 150,
                  width: 150,
                ),
              ), //$path
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
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SpecificsCard(
                      name: 'Rentee Email',
                      name2: rentee_email,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SpecificsCard(
                      name: 'Vehicle Number',
                      name2: vehicle_number,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SpecificsCard(
                      name: 'Description',
                      name2: description,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SpecificsCard(
                      name: 'From',
                      name2: fromDate!.split("T")[0] +
                          " " +
                          fromDate!.split("T")[1].split("Z")[0],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SpecificsCard(
                      name: 'To',
                      name2: toDate!.split("T")[0] +
                          " " +
                          toDate!.split("T")[1].split("Z")[0],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SpecificsCard(
                      name: 'Charge',
                      name2: price,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
