import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'package:http/http.dart' as http;

class Custom_duty extends StatefulWidget {
  Custom_duty({Key? key}) : super(key: key);

  @override
  _Custom_dutyState createState() => _Custom_dutyState();
}

class _Custom_dutyState extends State<Custom_duty> {
  TextEditingController searchText = TextEditingController();
  File? selectedImage;
  handleCamera() async {
    Navigator.pop(context);
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 675, maxWidth: 690);
    setState(() {
      this.selectedImage = File(file!.path);
    });
  }

  handleSearch() async {
    var url = Uri.parse("https://mobial.herokuapp.com/api/get_cduty");
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);
  }

  // handleSearch() async {
  //   var url = Uri.parse("http://192.168.109.1:3001/api/addcdutyitem");
  //   var response = await http.post(url,
  //       headers: <String, String>{
  //         'content-type': 'application/json',
  //         "Accept": "application/json",
  //         "charset": "utf-8"
  //       },
  //       body: json.encode({
  //         'item': searchText.text.toString(),
  //       }));
  //   print(response.statusCode);
  //   print(response.body);
  // }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      this.selectedImage = File(file!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Camera'),
                      onTap: () {
                        handleCamera();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Photo Gallery'),
                    onTap: () {
                      handleChooseFromGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      drawer: drawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: searchText,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    handleSearch();
                  },
                  icon: Icon(Icons.search),
                ),
                border: UnderlineInputBorder(),
                labelText: 'Enter item name',
              ),
            ),
          ),
          IconButton(
            onPressed: () => {_showPicker(context)},
            icon: Icon(Icons.add_a_photo),
          ),
        ],
      ),
    );
  }
}
