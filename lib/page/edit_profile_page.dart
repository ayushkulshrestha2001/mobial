import 'dart:convert';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:mobial/model/user.dart';
import 'package:mobial/utils/user_preferences.dart';
import 'package:mobial/widgets/appbar_widget.dart';
import 'package:mobial/widgets/button_widget.dart';
import 'package:mobial/widgets/profile_widget.dart';
import 'package:mobial/widgets/textfield_widget.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
  editName() async {
    var url = Uri.parse("https://mobial.herokuapp.com/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'name': user.name,
        }));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  editUsername() async {
    var url = Uri.parse("https://mobial.herokuapp.com/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'username': user.username,
        }));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  editPhone() async {
    var url = Uri.parse("https://mobial.herokuapp.com/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'phone': user.phone,
        }));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: false,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) {},
                ),
                IconButton(
                  onPressed: () {
                    editName();
                  },
                  icon: const Icon(Icons.upload),
                ),
                TextFieldWidget(
                  label: 'Phone',
                  text: user.phone,
                  onChanged: (about) {},
                ),
                IconButton(
                  onPressed: () {
                    editPhone();
                  },
                  icon: const Icon(Icons.upload),
                ),
                TextFieldWidget(
                  label: 'Username',
                  text: user.username,
                  onChanged: (about) {},
                ),
                IconButton(
                  onPressed: () {
                    editUsername();
                  },
                  icon: const Icon(Icons.upload),
                ),
              ],
            ),
          ),
        ),
      );
}
