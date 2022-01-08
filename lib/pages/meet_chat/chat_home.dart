import 'dart:convert';
import 'package:mobial/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:mobial/pages/meet_chat/chat_screen.dart';
import 'package:http/http.dart' as http;
import 'package:mobial/widgets/drawer.dart';
import 'package:mobial/widgets/header.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatHome extends StatefulWidget {
  final String? logInUser;
  ChatHome({this.logInUser});
  @override
  ChatScreenState createState() {
    return ChatScreenState(logInUser: logInUser);
  }
}

class ChatScreenState extends State<ChatHome> {
  bool isLoading = false;
  final String? logInUser;
  ChatScreenState({this.logInUser});
  List users = [];
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse('https://mobial.azurewebsites.net/api/users');
    http.Response response = await http.get(url);
    print(response.body);
    var decodedData = jsonDecode(response.body);
    print(decodedData);
    setState(() {
      users = decodedData;
      isLoading = false;
    });
    print(users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffd5e4e1),
        appBar: header(context),
        drawer: drawer(context),
        body: !isLoading
            ? (Container(
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, i) {
                      if (users[i]['email'] != logInUser) {
                        String picture = users[i]['picture'] ??
                            "https://firebasestorage.googleapis.com/v0/b/shrink4shrink.appspot.com/o/663328.png?alt=media&token=2bcd32f3-9872-40f3-b59d-eee666ff2b79";
                        ChatModel newUser = ChatModel(
                          name: users[i]['name'],
                          message: users[i]['username'],
                          time: users[i]['phone'],
                          email: users[i]['email'],
                          picture: picture,
                        );
                        return Column(
                          children: <Widget>[
                            Card(
                                child: ListTile(
                              hoverColor: Colors.grey,
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
                                backgroundImage: NetworkImage(newUser.picture),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    newUser.name,
                                    style: GoogleFonts.signika(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    newUser.time,
                                    style: GoogleFonts.signika(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Container(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  newUser.message,
                                  style: GoogleFonts.signika(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ))
                          ],
                        );
                      }
                      return Container();
                    })))
            : circularProgress());
  }
}

class ChatModel {
  final String name;
  final String message;
  final String time;
  final String email;
  final String picture;
  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.email,
    required this.picture,
  });
}
