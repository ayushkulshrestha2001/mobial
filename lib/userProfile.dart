import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobial/model/user.dart';
import 'package:mobial/page/edit_profile_page.dart';
import 'package:mobial/utils/user_preferences.dart';
import 'package:mobial/widgets/appbar_widget.dart';
import 'package:mobial/widgets/button_widget.dart';
import 'package:mobial/widgets/numbers_widget.dart';
import 'package:mobial/widgets/profile_widget.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  final String? recieverEmail;
  UserProfile({this.recieverEmail});
  @override
  _ProfiUserProfile createState() =>
      _ProfiUserProfile(recieverEmail: recieverEmail);
}

class _ProfiUserProfile extends State<UserProfile> {
  final String? recieverEmail;
  _ProfiUserProfile({this.recieverEmail});
  String name = "";
  String email = "";
  String phone = "";
  String username = "";
  String picture =
      'https://firebasestorage.googleapis.com/v0/b/shrink4shrink.appspot.com/o/663328.png?alt=media&token=2bcd32f3-9872-40f3-b59d-eee666ff2b79';
  @override
  void initState() {
    super.initState();
    getRecieverData();
  }

  getRecieverData() async {
    print(recieverEmail);
    var url = Uri.parse("https://mobial.herokuapp.com/api/userdata");
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'content-type': 'application/json',
        "Accept": "application/json",
        "charset": "utf-8"
      },
      body: json.encode({
        'email': recieverEmail,
      }),
    );
    print(response.body);
    var data = jsonDecode(response.body);
    setState(() {
      name = data['name'];
      email = data['email'];
      phone = data['phone'];
      username = data['username'];
      picture = data['picture'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = UserPreferences.myUser;

    return Center(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: picture,
                onClicked: () {},
              ),
              const SizedBox(height: 24),
              buildName(user),
              const SizedBox(height: 48),
              buildAbout(user),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            "$name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            "$email",
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Phone',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  '$phone',
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Username',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  '$username',
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      );
}
