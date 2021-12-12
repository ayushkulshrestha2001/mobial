import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';

class Custom_duty extends StatefulWidget {
  Custom_duty({Key? key}) : super(key: key);

  @override
  _Custom_dutyState createState() => _Custom_dutyState();
}

class _Custom_dutyState extends State<Custom_duty> {
  File? selectedImage;
  handleCamera() async {
    Navigator.pop(context);
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 675, maxWidth: 690);
    setState(() {
      this.selectedImage = File(file!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: header(context),
        drawer: drawer(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      print("helo");
                    },
                    icon: Icon(Icons.search),
                  ),
                  border: UnderlineInputBorder(),
                  labelText: 'Enter item name',
                ),
              ),
            ),
            IconButton(
              onPressed: handleCamera,
              icon: Icon(Icons.camera_alt),
            ),
          ],
        ),
      ),
    );
  }
}
