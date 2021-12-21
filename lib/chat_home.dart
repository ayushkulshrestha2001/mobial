import 'package:flutter/material.dart';
import 'package:mobial/chat_screen.dart';

List<ChatModel> dummyData = [
  ChatModel(
      name: "Bikal Thapa",
      message: "Hello chat ui",
      time: "10:34",
      avatarUrl: "http://www.binaythapa.com.np/img/about.jpg"),
  ChatModel(
      name: "Neeraj Neupane",
      message: "Hi when should we fix meeting",
      time: "6:20",
      avatarUrl: "http://www.binaythapa.com.np/img/about.jpg"),
  ChatModel(
      name: "Prem Pun",
      message: "Hi Binay",
      time: "7:40",
      avatarUrl: "http://www.binaythapa.com.np/img/about.jpg"),
  ChatModel(
      name: "Bipin Pandey",
      message: "Hello",
      time: "1:10",
      avatarUrl: "http://www.binaythapa.com.np/img/about.jpg"),
  ChatModel(
      name: "Manjar Hussain",
      message: "Hello Binay Can we talk",
      time: "4:00",
      avatarUrl: "http://www.binaythapa.com.np/img/about.jpg"),
  ChatModel(
      name: "Henric Siemsen",
      message: "Binay can we have a chat",
      time: "3:15",
      avatarUrl: "http://www.binaythapa.com.np/img/about.jpg"),
];

class ChatHome extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, i) => Column(
        children: <Widget>[
          Divider(
            height: 10.0,
          ),
          ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(dummyData[i].name))),
            leading: CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(dummyData[i].avatarUrl),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  dummyData[i].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  dummyData[i].time,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                dummyData[i].message,
                style: TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  ChatModel(
      {required this.name,
      required this.message,
      required this.time,
      required this.avatarUrl});
}
