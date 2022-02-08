import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:linkify/linkify.dart';

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
      handleResponse(_text);
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
      handleResponse(messageController.text);
    }
    messageController.clear();
  }

  handleResponse(String text) async {
    var url = Uri.parse(
        'https://mobialqna.azurewebsites.net/qnamaker/knowledgebases/a4980818-d160-4e93-8bfc-2abeed59c5a7/generateAnswer');
    var endPointKey = 'd25b1656-ae4a-41a5-92c5-1fc00295e357';
    http.Response response = await http.post(url,
        headers: <String, String>{
          "Authorization": endPointKey,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "question": text,
        }));
    var decodedData = json.decode(response.body);
    print(decodedData['answers'][0]['answer']);
    if (decodedData['answers'][0]['answer'] != 'No good match found in KB.') {
      _firestore.collection('chatbotMessages').add({
        'message': decodedData['answers'][0]['answer'],
        'sender': 'bot',
        'receiver': storage.getItem('user')['email'],
        'time': FieldValue.serverTimestamp(),
      });
    } else {
      _firestore.collection('chatbotMessages').add({
        'message': 'Looks Like I have to study more...',
        'sender': 'bot',
        'receiver': storage.getItem('user')['email'],
        'time': FieldValue.serverTimestamp(),
      });
    }
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
            backgroundColor: Colors.black,
            child: Image(
              image: AssetImage(
                'assets/img/only-bial-removebg-preview.png',
              ),
              width: 45,
              fit: BoxFit.fill,
            )),
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
                backgroundColor: Colors.black,
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
                  backgroundColor: Colors.black,
                  child: _isListening ? Icon(Icons.close) : Icon(Icons.mic),
                ),
              ),
              GestureDetector(
                onTap: handleSubmit,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
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
  // String extractLink(String input) {
  //   var elements = linkify(input,
  //       options: LinkifyOptions(
  //         humanize: false,
  //       ));
  //   for (var e in elements) {
  //     if (e is LinkableElement) {
  //       return e.url;
  //     }
  //   }
  //   return "";
  // }
  Widget build(BuildContext context) {
    String txt = text;
    String anchor = "";
    String url = "";
    for (int i = 0; i < txt.length; i++) {
      if (txt[i] == '[') {
        i = i + 1;
        while (txt[i] != ']') {
          anchor = anchor + txt[i];
          i++;
        }
      }
      if (txt[i] == '(') {
        i = i + 1;
        while (txt[i] != ')') {
          url = url + txt[i];
          i++;
        }
      }
    }
    txt = txt.replaceAll(url, "");
    txt = txt.replaceAll(anchor, "");
    txt = txt.replaceAll("[]()", "");
    // String clickable = extractLink()
    print(txt);
    print(anchor);
    print(url);
    if (sender == storage.getItem('user')['email']) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Color(0xfff9f9fa),
          elevation: 0,
          child: ListTile(
            isThreeLine: true,
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
                  style:
                      GoogleFonts.signika(fontSize: 12.0, color: Colors.black),
                ),
              ],
            ),
            subtitle: Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(" "),
                Text(
                  "$txt",
                  style:
                      GoogleFonts.signika(fontSize: 18.0, color: Colors.black),
                  maxLines: 20,
                ),
              ],
            )),
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        color: Color(0xffeeeeee),
        child: ListTile(
            contentPadding: EdgeInsets.only(
              left: 15.0,
            ),
            isThreeLine: true,
            leading: new CircleAvatar(
              child: new Text(sender[0]),
            ),
            title: Text('BOT',
                style:
                    GoogleFonts.signika(fontSize: 12.0, color: Colors.black)),
            subtitle: Column(
              children: [
                !anchor.isEmpty
                    ? (TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueAccent),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              color: Colors.white,
                            ))),
                        onPressed: () => launch(url),
                        child: Text(
                          '$anchor',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                    : Container(),
                Text(
                  "$txt",
                  style:
                      GoogleFonts.signika(fontSize: 18.0, color: Colors.black),
                  maxLines: 20,
                )
              ],
            )),
      ),
    );
  }
}
