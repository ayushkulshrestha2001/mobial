import 'package:flutter/material.dart';
import 'package:mobial/pages/car.dart/renter_form.dart';
import 'package:mobial/widgets/specific_card.dart';

class LendCarDetails extends StatelessWidget {
  final mainHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 30);

  final subHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  final basicHeading = TextStyle(fontSize: 15);
  final String? id;
  final String? picture;
  final String? vehicleName;
  final String? price;
  final String? fromDate;
  final String? toDate;
  final String? renteeEmail;
  final String? vehicleNumber;
  final String? description;
  final String? vehicleType;
  final String? path;

  LendCarDetails(
      {this.id,
      this.vehicleName,
      this.price,
      this.fromDate,
      this.toDate,
      this.renteeEmail,
      this.vehicleNumber,
      this.description,
      this.vehicleType,
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
              Text("$vehicleName", style: mainHeading),
              Text(
                "$vehicleType",
                style: basicHeading,
              ),
              Hero(
                tag: "$vehicleName",
                child: Image.asset(
                  "assets/img/car.png",
                  height: 150,
                  width: 150,
                ),
              ),
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
                      name2: renteeEmail,
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
                      name2: vehicleNumber,
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
