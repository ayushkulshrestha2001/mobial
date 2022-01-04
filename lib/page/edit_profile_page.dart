import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobial/model/user.dart';
import 'package:mobial/utils/user_preferences.dart';
import 'package:mobial/widgets/appbar_widget.dart';
import 'package:mobial/widgets/profile_widget.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = new LocalStorage('mobial');

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? usernameController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: user.name);
    phoneController = TextEditingController(text: user.phone);
    usernameController = TextEditingController(text: user.username);
  }

  editName() async {
    print(nameController!.text);
    var url = Uri.parse("https://mobial.herokuapp.com/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'name': nameController!.text,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      storage.getItem("user")['name'] = nameController!.text;
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  editUsername() async {
    print(usernameController!.text);
    var url = Uri.parse("https://mobial.herokuapp.com/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'name': usernameController!.text,
        }));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  editPhone() async {
    print(phoneController!.text);
    var url = Uri.parse("https://mobial.herokuapp.com/api/update_profile");
    var response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          'email': user.email,
          'name': phoneController!.text,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    editName();
                  },
                  icon: const Icon(Icons.upload),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    editPhone();
                  },
                  icon: const Icon(Icons.upload),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ],
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
