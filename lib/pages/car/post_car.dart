import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobial/widgets/header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobial/widgets/widget_button.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';

final LocalStorage storage = LocalStorage('mobial');

class PostCar extends StatefulWidget {
  PostCar({Key? key}) : super(key: key);

  @override
  _PostCarState createState() => _PostCarState();
}

class _PostCarState extends State<PostCar> {
  bool checkedValue = false;
  bool register = true;
  List textfieldsStrings = [
    "", //vehicle type
    "", //vehicle number
    "", //availability
    "", //brand
    "", //charges
  ];
  File? selectedImage;
  final _firstnamekey = GlobalKey<FormState>();
  final _lastNamekey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController chargeController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String vehicleType = 'Mini/Hitchback';
  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.000");
  String picUrl = "";
  String docUrl = "";

  handleCamera(String type) async {
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

    var val = storage.uri();
    String finalUrl = "$val" + "mobialc/$name";
    print(finalUrl);
    setState(() {
      if (type == 'picture') {
        picUrl = finalUrl;
      } else {
        docUrl = finalUrl;
      }
    });
  }

  handleChooseFromGallery(String type) async {
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

    var val = storage.uri();
    String finalUrl = "$val" + "mobialc/$name";
    print(finalUrl);
    setState(() {
      if (type == 'picture') {
        picUrl = finalUrl;
      } else {
        docUrl = finalUrl;
      }
    });
  }

  void _showPicker(context, String type) {
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
                        handleCamera(type);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Photo Gallery'),
                    onTap: () {
                      handleChooseFromGallery(type);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  postCar() async {
    print('in post car function');
    String fromString = dateFormat.format(fromDate);
    String toString = dateFormat.format(toDate);
    if (chargeController.text != "") {
      if (vehicleNameController.text != "") {
        if (vehicleNumberController.text != "") {
          if (descriptionController != "") {
            if (fromString != "" && toString != "") {
              if (picUrl != "" && docUrl != "") {
                var url =
                    Uri.parse("https://mobial.azurewebsites.net/api/post_car");
                http.Response response = await http.post(url,
                    headers: <String, String>{
                      'content-type': 'application/json',
                      "Accept": "application/json",
                      "charset": "utf-8"
                    },
                    body: json.encode({
                      'rentee_email': storage.getItem('user')['email'],
                      'vehicle_name': vehicleNameController.text,
                      'vehicle_type': vehicleType,
                      'vehicle_number': vehicleNumberController.text,
                      'description': descriptionController.text,
                      'from_date': fromString,
                      'to_date': toString,
                      'car_rc': docUrl,
                      'vehicle_picture': picUrl,
                      'expected_charge': chargeController.text,
                    }));
                print(response.statusCode);
                print(response.body);
                var data = jsonDecode(response.body);
                if (data == 'Car Sucessfully Created') {
                  Navigator.of(context).pop();
                } else {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              'Error in Posting. Please check the form and try again '),
                        );
                      });
                }
              }
            }
          }
        }
      }
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                  child: Text('ERROR: Every Field is Compulsory to be filled')),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: header(context),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                        child: Align(
                          child: Text(
                            'Hey there,',
                            style: GoogleFonts.poppins(
                              color: Colors.blueAccent,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child: Align(
                            child: Text(
                          'Enter Vehicle Details',
                          style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(
                                Icons.car_rental,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              DropdownButton<String>(
                                value: vehicleType,
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.black,
                                ),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    vehicleType = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Mini/Hitchback',
                                  'Sedan',
                                  'SUV',
                                  'Two-wheeler'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      buildTextField("Expencted Charge", Icons.money, false,
                          size, _firstnamekey, 0, chargeController),
                      buildTextField("Vehicle Name", Icons.person_outlined,
                          false, size, _lastNamekey, 1, vehicleNameController),
                      Form(
                        child: buildTextField(
                            "Vehicle Number",
                            Icons.email_outlined,
                            false,
                            size,
                            _emailKey,
                            2,
                            vehicleNumberController),
                      ),
                      Form(
                        child: buildTextField(
                            "Description",
                            Icons.description_outlined,
                            false,
                            size,
                            _confirmPasswordKey,
                            4,
                            descriptionController),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 8.0, 10.0, 5.0),
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'From',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onDateSelected: (DateTime value) {
                              print(value);
                              setState(() {
                                fromDate = value;
                              });
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 8.0, 10.0, 5.0),
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'To',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onDateSelected: (DateTime value) {
                              print(value);
                              setState(() {
                                toDate = value;
                              });
                            },
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 22.0),
                        child: ElevatedButton(
                          onPressed: () => {_showPicker(context, 'document')},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo),
                              SizedBox(width: 10.0),
                              Text("Upload Car Documnets (RC)")
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 22.0),
                        child: ElevatedButton(
                          onPressed: () => {_showPicker(context, 'picture')},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo),
                              SizedBox(width: 10.0),
                              Text("Upload Car Image")
                            ],
                          ),
                        ),
                      ),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 500),
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        child: ButtonWidget(
                          text: "Post Car",
                          backColor: [
                            Colors.blueAccent,
                            Colors.blueAccent,
                          ],
                          textColor: const [
                            Colors.white,
                            Colors.white,
                          ],
                          onPressed: () async {
                            postCar();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool pwVisible = false;
  Widget buildTextField(
    String hintText,
    IconData icon,
    bool password,
    size,
    Key key,
    int stringToEdit,
    TextEditingController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.black),
            onChanged: (value) {
              setState(() {
                textfieldsStrings[stringToEdit] = value;
              });
            },
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              contentPadding: EdgeInsets.only(
                top: size.height * 0.012,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.005,
                ),
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
              suffixIcon: password
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pwVisible = !pwVisible;
                          });
                        },
                        child: pwVisible
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: Color(0xff7B6F72),
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                color: Color(0xff7B6F72),
                              ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, context, size) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }
}
