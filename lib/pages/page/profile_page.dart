import 'package:flutter/material.dart';
import 'package:mobial/model/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:mobial/pages/page/edit_profile_page.dart';
import 'package:mobial/utils/user_preferences.dart';
import 'package:mobial/widgets/profile_widget.dart';
import 'package:mobial/widgets/header.dart';
import 'package:mobial/widgets/progress.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final LocalStorage storage = new LocalStorage('mobial');

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  void addItemsToLocalStorage(var data) async {
    await storage.setItem('user', data);
    print("hello");
    print(storage.getItem('user'));
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    var bUrl1 = Uri.parse("https://mobial.azurewebsites.net/api/userdata");
    var response1 = await http.post(bUrl1,
        headers: <String, String>{
          'content-type': 'application/json',
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({'email': UserPreferences.myUser.email}));
    print(response1.statusCode);
    print(response1.body);
    storage.clear();
    var data = jsonDecode(response1.body);
    addItemsToLocalStorage(data);
    setState(() {
      isLoading = false;
      _refreshController.refreshCompleted();
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var user = UserPreferences.myUser;

    return Center(
      child: Builder(
        builder: (context) => Scaffold(
            backgroundColor: Color(0xffd5e4e1),
            appBar: header(context),
            body: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              onRefresh: () => getUser(),
              child: !isLoading
                  ? (ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        ProfileWidget(
                          imagePath: storage.getItem('user')["picture"],
                          onClicked: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        buildName(user),
                        const SizedBox(height: 48),
                        buildAbout(user),
                      ],
                    ))
                  : circularProgress(),
            )),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            storage.getItem('user')["name"],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            storage.getItem('user')["email"],
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
                  storage.getItem('user')["phone"],
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
                  storage.getItem('user')["username"],
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'DOB',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  storage.getItem('user')["dob"],
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      );
}
