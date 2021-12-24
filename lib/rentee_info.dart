import 'package:flutter/material.dart';
// import 'package:mobial/widgets/drawer.dart';
// import 'package:mobial/widgets/header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobial/widgets/widget_button.dart';
import 'package:date_field/date_field.dart';

class RenteeInfo extends StatefulWidget {
  RenteeInfo({Key? key}) : super(key: key);

  @override
  _RenteeInfoState createState() => _RenteeInfoState();
}

class _RenteeInfoState extends State<RenteeInfo> {
  String value = 'Mini/Hitchback';
  bool checkedValue = false;
  bool register = true;
  List textfieldsStrings = [
    "", //vehicle type
    "", //vehicle number
    "", //availability
    "", //brand
    "", //charges
  ];

  final _firstnamekey = GlobalKey<FormState>();
  final _lastNamekey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(color: const Color(0xff151f2c)),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Align(
                          child: Text(
                            'Hey there,',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
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
                            color: Colors.white,
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
                            color: isDarkMode
                                ? Colors.black
                                : const Color(0xffF7F8F8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(
                                Icons.car_rental,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              DropdownButton<String>(
                                value: value,
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.grey,
                                ),
                                elevation: 16,
                                style: const TextStyle(color: Colors.grey),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    value = newValue!;
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
                      buildTextField(
                        "Vehicle Type",
                        Icons.person_outlined,
                        false,
                        size,
                        (valuename) {
                          if (valuename.length <= 2) {
                            buildSnackError(
                              'Invalid name',
                              context,
                              size,
                            );
                            return '';
                          }
                          return null;
                        },
                        _firstnamekey,
                        0,
                        isDarkMode,
                      ),
                      buildTextField(
                        "Vehicle Name",
                        Icons.person_outlined,
                        false,
                        size,
                        (valuesurname) {
                          if (valuesurname.length <= 2) {
                            buildSnackError(
                              'Invalid last name',
                              context,
                              size,
                            );
                            return '';
                          }
                          return null;
                        },
                        _lastNamekey,
                        1,
                        isDarkMode,
                      ),
                      Form(
                        child: buildTextField(
                          "Vehicle Number",
                          Icons.email_outlined,
                          false,
                          size,
                          (valuemail) {
                            if (valuemail.length < 5) {
                              buildSnackError(
                                'Invalid email',
                                context,
                                size,
                              );
                              return '';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                .hasMatch(valuemail)) {
                              buildSnackError(
                                'Invalid email',
                                context,
                                size,
                              );
                              return '';
                            }
                            return null;
                          },
                          _emailKey,
                          2,
                          isDarkMode,
                        ),
                      ),
                      Form(
                        child: buildTextField(
                          "Availability",
                          Icons.lock_outline,
                          false,
                          size,
                          (valuepassword) {
                            if (valuepassword.length < 6) {
                              buildSnackError(
                                'Invalid password',
                                context,
                                size,
                              );
                              return '';
                            }
                            return null;
                          },
                          _passwordKey,
                          3,
                          isDarkMode,
                        ),
                      ),
                      Form(
                        child: buildTextField(
                          "Description",
                          Icons.description_outlined,
                          false,
                          size,
                          (valuepassword) {
                            if (valuepassword != textfieldsStrings[3]) {
                              buildSnackError(
                                'Passwords must match',
                                context,
                                size,
                              );
                              return '';
                            }
                            return null;
                          },
                          _confirmPasswordKey,
                          4,
                          isDarkMode,
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: size.height * 0.025),
                      //   child: Container(
                      //     width: size.width * 0.9,
                      //     height: size.height * 0.05,
                      //     decoration: BoxDecoration(
                      //       color: isDarkMode
                      //           ? Colors.black
                      //           : const Color(0xffF7F8F8),
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(15)),
                      //     ),
                      //     child: Row(
                      //       //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         SizedBox(
                      //           width: 10.0,
                      //         ),
                      //         Icon(
                      //           Icons.calendar_today_outlined,
                      //           color: Colors.grey,
                      //         ),
                      //         SizedBox(
                      //           width: 10.0,
                      //         ),
                      //         DateTimeFormField(
                      //           decoration: InputDecoration(
                      //             hintStyle: TextStyle(color: Colors.black),
                      //             errorStyle:
                      //                 TextStyle(color: Colors.redAccent),
                      //             suffixIcon: Icon(
                      //               Icons.event_note,
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon:
                                  Icon(Icons.event_note, color: Colors.black),
                              labelText: 'Only time',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onDateSelected: (DateTime value) {
                              print(value);
                            },
                          ),
                        ),
                        // child: DateTimeFormField(
                        //   decoration: const InputDecoration(
                        //     hintStyle: TextStyle(color: Colors.black45),
                        //     errorStyle: TextStyle(color: Colors.redAccent),
                        //     border: OutlineInputBorder(),
                        //     suffixIcon: Icon(Icons.event_note),
                        //     labelText: 'Only time',
                        //   ),
                        //   mode: DateTimeFieldPickerMode.time,
                        //   autovalidateMode: AutovalidateMode.always,
                        //   validator: (e) => (e?.day ?? 0) == 1
                        //       ? 'Please not the first day'
                        //       : null,
                        //   onDateSelected: (DateTime value) {
                        //     print(value);
                        //   },
                        // ),
                      ),

                      AnimatedPadding(
                        duration: const Duration(milliseconds: 500),
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        child: ButtonWidget(
                          text: "Post Car",
                          backColor: [
                            Colors.black,
                            Colors.black,
                          ],
                          textColor: const [
                            Colors.white,
                            Colors.white,
                          ],
                          onPressed: () async {
                            if (_firstnamekey.currentState!.validate()) {
                              if (_lastNamekey.currentState!.validate()) {
                                if (_emailKey.currentState!.validate()) {
                                  if (_passwordKey.currentState!.validate()) {
                                    if (_confirmPasswordKey.currentState!
                                        .validate()) {
                                      if (checkedValue == false) {
                                        buildSnackError(
                                            'Accept our Privacy Policy and Term Of Use',
                                            context,
                                            size);
                                      } else {
                                        print('register');
                                      }
                                    }
                                  }
                                }
                              }
                            }
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
    FormFieldValidator validator,
    Key key,
    int stringToEdit,
    bool isDarkMode,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : const Color(0xffF7F8F8),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: TextFormField(
            style: TextStyle(
                color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
            onChanged: (value) {
              setState(() {
                textfieldsStrings[stringToEdit] = value;
              });
            },
            validator: validator,
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
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
                  color: const Color(0xff7B6F72),
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
