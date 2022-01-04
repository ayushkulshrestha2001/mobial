import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobial/chat_screen.dart';
import 'package:http/http.dart' as http;
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';

class ChatHome extends StatefulWidget {
  final String? logInUser;
  ChatHome({this.logInUser});
  @override
  ChatScreenState createState() {
    return ChatScreenState(logInUser: logInUser);
  }
}

class ChatScreenState extends State<ChatHome> {
  final String? logInUser;
  ChatScreenState({this.logInUser});
  List users = [];
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() async {
    var url = Uri.parse('https://mobial.herokuapp.com/api/users');
    http.Response response = await http.get(url);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    print(decodedData);
    setState(() {
      users = decodedData;
    });
    print(users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      drawer: drawer(context),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, i) {
            ChatModel newUser = ChatModel(
              name: users[i]['name'],
              message: users[i]['username'],
              time: users[i]['phone'],
              email: users[i]['email'],
            );
            return Column(
              children: <Widget>[
                Divider(
                  height: 10.0,
                ),
                ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                logInUser: logInUser,
                                sender: logInUser,
                                reciever: newUser.name,
                                recieverEmail: newUser.email,
                              ))),
                  leading: CircleAvatar(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey,
                    //backgroundImage: NetworkImage(dummyData[i].avatarUrl),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        newUser.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        newUser.time,
                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ],
                  ),
                  subtitle: Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      newUser.message,
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}

class ChatModel {
  final String name;
  final String message;
  final String time;
  final String email;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.email,
  });
}
