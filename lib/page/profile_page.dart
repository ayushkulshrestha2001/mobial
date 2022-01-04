import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobial/model/user.dart';
import 'package:mobial/page/edit_profile_page.dart';
import 'package:mobial/utils/user_preferences.dart';
import 'package:mobial/widgets/appbar_widget.dart';
import 'package:mobial/widgets/button_widget.dart';
import 'package:mobial/widgets/numbers_widget.dart';
import 'package:mobial/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                imagePath: user.imagePath,
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
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
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
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
                  user.phone,
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
                  user.username,
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      );
}
