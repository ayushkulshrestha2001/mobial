import 'package:flutter/material.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

final LocalStorage storage = LocalStorage('mobial');

class Chatbot extends StatefulWidget {
  Chatbot({Key? key}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  TextEditingController messageController = TextEditingController();

  // SpeechToText _speechToText = SpeechToText();
  // bool _speechEnabled = false;
  // String _lastWords = '';
  @override
  void initState() {
    super.initState();
    //SpeechToTextNotInitializedException();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
        debugLogging: true,
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            messageController.text = _text;
            print(_text);
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      handleVoiceSubmit();
    }
  }

  handleVoiceSubmit() {
    print(_text);
    if (_text != "") {
      _firestore.collection('chatbotMessages').add({
        'message': _text,
        'sender': storage.getItem('user')['email'],
        'receiver': 'bot',
        'time': FieldValue.serverTimestamp(),
      });
    }
    messageController.clear();
  }

  handleSubmit() {
    print(messageController.text);
    if (messageController.text != "") {
      _firestore.collection('chatbotMessages').add({
        'message': messageController.text,
        'sender': storage.getItem('user')['email'],
        'receiver': 'bot',
        'time': FieldValue.serverTimestamp(),
      });
    }
    messageController.clear();
  }

  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 60.0,
      child: CustomPopupMenu(
        arrowColor: Colors.white,
        child: CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/mobial.appspot.com/o/chaticon.png?alt=media&token=7e9f5a17-4bc9-41d5-9ac9-dda9fe738aba',
          ),
          //backgroundColor: Colors.blue,
          //child: Icon(Icons.chat, color: Colors.white),
        ),
        menuBuilder: chatBuilder,
        pressType: PressType.singleClick,
      ),
    );
  }

  Widget chatBuilder() {
    // setState(() {
    //   isOpen = true;
    // });
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: 380.0,
      height: 500.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.0,
          ),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.smart_toy_outlined, color: Colors.white)),
            title: Text(
              'Welcome ${storage.getItem('user')['name']}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Divider(
            height: 2.0,
          ),
          Container(
            height: 370,
            child: StreamBuilder(
              stream: _firestore
                  .collection('chatbotMessages')
                  .orderBy('time')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs.reversed;
                  List<ChatMessage> messageWidgets = [];

                  for (var message in messages) {
                    messageWidgets.add(
                      ChatMessage(
                          text: message['message'],
                          sender: message['sender'],
                          reciever: message['receiver']),
                    );
                  }
                  return Container(
                    child: Expanded(
                      child: ListView(
                        reverse: true,
                        padding: EdgeInsets.zero,
                        children: messageWidgets,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          // SizedBox(
          //   height: 370.0,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                width: 250.0,
                child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    label: Text('Write Your Message'),
                    hintText: 'Write Your Message',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _listen,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: _isListening ? Icon(Icons.close) : Icon(Icons.mic),
                ),
              ),
              GestureDetector(
                onTap: handleSubmit,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.send),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  String text;
  String sender;
  String reciever;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.reciever,
  });
  @override
  Widget build(BuildContext context) {
    String txt = text;
    if (sender == storage.getItem('user')['email']) {
      return Card(
        color: Color(0xffd5e4e1),
        elevation: 0,
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
              Text(
                '${storage.getItem('user')['name']}',
                style: GoogleFonts.signika(fontSize: 12.0, color: Colors.black),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(" "),
              Text(
                "$txt",
                style: GoogleFonts.signika(fontSize: 18.0, color: Colors.black),
              )
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
        child: new Text(sender[0]),
      ),
      title: Text('BOT',
          style: GoogleFonts.signika(fontSize: 12.0, color: Colors.black)),
      subtitle: Text(
        "$txt",
        style: GoogleFonts.signika(fontSize: 18.0, color: Colors.black),
      ),
    );
  }
}
