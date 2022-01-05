import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobial/model/message.dart';
import 'package:mobial/userProfile.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  final String? logInUser;
  final String? sender;
  final String? reciever;
  final String? recieverEmail;
  ChatScreen({this.sender, this.reciever, this.logInUser, this.recieverEmail});

  @override
  State createState() => new ChatScreenState(
      logInUser: logInUser,
      sender: sender,
      reciever: reciever,
      recieverEmail: recieverEmail);
}

class ChatScreenState extends State<ChatScreen> {
  final String? logInUser;
  final String? sender;
  final String? reciever;
  final String? recieverEmail;
  ChatScreenState(
      {this.logInUser, this.sender, this.reciever, this.recieverEmail});
  final TextEditingController textEditingController =
      new TextEditingController();
  List<MessageModel> translate = [];
  @override
  void initState() {
    super.initState();
    getMessageStream();
  }

  getMessageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var text in snapshot.docs) {
        print(text.data());
      }
    }
  }

  //to_lang
  String value = 'English';
  // String selectLanguage = 'English';
  // List<String> languages = ['Engilsh', 'French', 'Arabic', 'German'];
  // DropdownButton<String> androidDropdown() {
  //   List<DropdownMenuItem<String>> dropdownItems = [];
  //   for (String language in languages) {
  //     var newItem = DropdownMenuItem(
  //       child: Text(language),
  //       value: language,
  //     );
  //     dropdownItems.add(newItem);
  //   }

  //   return DropdownButton<String>(
  //     value: selectLanguage,
  //     items: dropdownItems,
  //     onChanged: (value) {
  //       setState(() {
  //         selectLanguage = value!;
  //       });
  //     },
  //   );
  // }

  // CupertinoPicker iOSPicker() {
  //   List<Text> pickerItems = [];
  //   for (String language in languages) {
  //     pickerItems.add(Text(language));
  //   }

  //   return CupertinoPicker(
  //     backgroundColor: Colors.lightBlue,
  //     itemExtent: 32.0,
  //     onSelectedItemChanged: (selectedIndex) {
  //       setState(() {
  //         selectLanguage = languages[selectedIndex];
  //       });
  //     },
  //     children: pickerItems,
  //   );
  // }

  void _handleSubmit(String text) {
    if (textEditingController.text != "") {
      _firestore.collection('messages').add({
        'message': textEditingController.text,
        'sender': sender,
        'reciever': recieverEmail,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    textEditingController.clear();
  }

  Widget _textComposerWidget() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "Enter your message"),
                controller: textEditingController,
                onSubmitted: _handleSubmit,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _handleSubmit(textEditingController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  showProfile() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UserProfile(
              recieverEmail: recieverEmail,
            )));
  }

  // showPicker() {
  //   return Platform.isIOS ? iOSPicker() : androidDropdown();
  // }

  // void _showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //             child: Platform.isIOS ? iOSPicker() : androidDropdown());
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: showProfile,
          child: Text("$reciever"),
        ),
        // actions: [
        //   DropdownButton<String>(
        //     value: value,
        //     icon: const Icon(
        //       Icons.arrow_downward,
        //       color: Colors.grey,
        //     ),
        //     //elevation: 16,
        //     style: const TextStyle(color: Colors.grey),
        //     onChanged: (String? newValue) {
        //       setState(() {
        //         value = newValue!;
        //       });
        //     },
        //     items: <String>['Engilsh', 'French', 'Arabic', 'German']
        //         .map<DropdownMenuItem<String>>((String value) {
        //       return DropdownMenuItem<String>(
        //         value: value,
        //         child: Text(value),
        //       );
        //     }).toList(),
        //   ),
        // ],
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs.reversed;
                  print(messages.length);
                  List<ChatMessage> messageWidgets = [];

                  for (var message in messages) {
                    final messageText = message['message'];
                    final messageSender = message['sender'];
                    final messageReciever = message['reciever'];
                    final messageTime = message['timestamp'].toString();
                    translate.add(MessageModel(
                        sender: messageSender,
                        text: messageText,
                        reciever: messageReciever,
                        timestamp: messageTime));
                    // translate.every((element) {
                    //   print(element);
                    //   return element.text != "";
                    // });
                    if ((messageSender == logInUser &&
                            messageReciever == recieverEmail) ||
                        (messageSender == recieverEmail &&
                            messageReciever == logInUser)) {
                      messageWidgets.add(ChatMessage(
                        logInUser: logInUser!,
                        text: messageText,
                        sender: messageSender,
                        reciever: messageReciever,
                        recieverEmail: recieverEmail!,
                      ));
                    }
                  }
                  return Expanded(
                      child: ListView(
                    reverse: true,
                    padding: EdgeInsets.zero,
                    children: messageWidgets,
                  ));
                }
                return Container();
              },
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _textComposerWidget(),
          )
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  String logInUser;
  String text;
  String sender;
  String reciever;
  String recieverEmail;
  //for optional params we use curly braces
  ChatMessage(
      {required this.logInUser,
      required this.text,
      required this.sender,
      required this.reciever,
      required this.recieverEmail});
  @override
  Widget build(BuildContext context) {
    String txt = getPrettyString(text);
    if (sender == logInUser) {
      return Card(
        elevation: 0.5,
        child: ListTile(
          isThreeLine: false,
          trailing: new CircleAvatar(
            child: new Text(
              sender[0],
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(" "),
              Text(sender, style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(" "),
              Text("$txt"),
            ],
          ),
        ),
      );
    }
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 15.0,
      ),
      isThreeLine: true,
      leading: new CircleAvatar(
        child: new Text(sender![0]),
      ),
      title: Text(sender, style: Theme.of(context).textTheme.subtitle1),
      subtitle: Text("$txt"),
    );
  }

  String getPrettyString(String str) {
    for (int i = 1; i < str.length; i++) {
      if (i % 30 == 0) {
        str = "${str.substring(0, i)} \n ${str.substring(i)}";
      }
    }
    return str;
  }
}
