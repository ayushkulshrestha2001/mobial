import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobial/rent_car_info.dart';
import 'package:mobial/rent_request_list.dart';
import 'package:mobial/widgets/header.dart';
import 'package:mobial/widgets/textfield_widget.dart';
import 'package:date_field/date_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';
import 'package:mobial/widgets/widget_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

final LocalStorage storage = LocalStorage('mobial');

class RenterForm extends StatefulWidget {
  final String? id;
  RenterForm({this.id});

  @override
  _RenterFormState createState() => _RenterFormState(id: id);
}

class _RenterFormState extends State<RenterForm> {
  final String? id;
  _RenterFormState({this.id});
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String idUrl = "";
  File? selectedImage;
  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.000");

  handleCamera() async {
    Navigator.pop(context);
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 675, maxWidth: 690);
    setState(() {
      this.selectedImage = File(file!.path);
    });
    var name = selectedImage!.path.split("/").last;
    print(name);

    var storage = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=mobial;AccountKey=625C6GU3riuquxpJbkz86DNcCYd4iqFS5RJNpOIW+imfdIz8UI429OXAAZr7gr0fHyKFLhMA7gF1fmgw/Zt48g==');
    await storage.putBlob('/mobialc/$name',
        bodyBytes: selectedImage!.readAsBytesSync(),
        contentType: lookupMimeType('$name'),
        type: BlobType.BlockBlob);

    String selectedPath = '/mobialc/$name';

    var val = storage.uri();
    String finalUrl = "$val" + "mobialc/$name";
    print(finalUrl);
    setState(() {
      idUrl = finalUrl;
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      this.selectedImage = File(file!.path);
    });
    var name = selectedImage!.path.split("/").last;
    print(name);

    var storage = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=mobial;AccountKey=625C6GU3riuquxpJbkz86DNcCYd4iqFS5RJNpOIW+imfdIz8UI429OXAAZr7gr0fHyKFLhMA7gF1fmgw/Zt48g==');
    await storage.putBlob('/mobialc/$name',
        bodyBytes: selectedImage!.readAsBytesSync(),
        contentType: lookupMimeType('$name'),
        type: BlobType.BlockBlob);

    String selectedPath = '/mobialc/$name';

    var val = storage.uri();
    String finalUrl = "$val" + "mobialc/$name";
    print(finalUrl);
    setState(() {
      idUrl = finalUrl;
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

  addRequest() async {
    print(id);
    String fromString = dateFormat.format(fromDate);
    String toString = dateFormat.format(toDate);
    var url = Uri.parse("https://mobial.herokuapp.com/api/rent_car");
    http.Response response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'vehicle_id': id,
          'renter_email': storage.getItem('user')['email'],
          'from_date': fromString,
          'to_date': toString,
          'id_proof': idUrl,
        }));
    print(response.body);
    print(response.statusCode);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RentRequestList()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: header(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              child: Center(
                  child: Text(
                "Please fill out the info for the owner to view",
                style: GoogleFonts.signika(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ))),
          SizedBox(
            height: 30.0,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'From',
                ),
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  print(value);
                  setState(() {
                    toDate = value;
                  });
                },
              )),
          SizedBox(height: 20.0),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'To',
                ),
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  print(value);
                  setState(() {
                    toDate = value;
                  });
                },
              )),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 22.0),
            child: ElevatedButton(
              onPressed: () => {_showPicker(context)},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo),
                  SizedBox(width: 10.0),
                  Text("Upload ID Proof")
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          AnimatedPadding(
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.only(top: size.height * 0.025),
            child: ButtonWidget(
              text: "Book",
              backColor: [
                Colors.blueAccent,
                Colors.blueAccent,
              ],
              textColor: const [
                Colors.white,
                Colors.white,
              ],
              onPressed: () async {
                addRequest();
              },
            ),
          ),
        ],
      ),
    );
  }
}
