import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_azure_tts/flutter_azure_tts.dart';
import 'package:flutter_azure_tts/src/audio/audio_output_format.dart';
import 'package:flutter_azure_tts/src/tts/tts_params.dart';
import 'package:audioplayers/audioplayers.dart';

final _firestore = FirebaseFirestore.instance;

final LocalStorage storage = LocalStorage('mobial');

AudioCache audioCache = AudioCache();
AudioPlayer audioPlayer = AudioPlayer();

text_to_speech(String text) async {
  final voicesResponse = await AzureTts.getAvailableVoices() as VoicesSuccess;
  final voice = voicesResponse.voices
      .where((element) =>
          element.voiceType == "Neural" && element.locale.startsWith("en-"))
      .toList(growable: false)[0];

  print("${voicesResponse.voices}");

  //final text = "Microsoft Speech Service Text-to-Speech API";

  TtsParams params = TtsParams(
      voice: voice,
      audioFormat: AudioOutputFormat.audio16khz32kBitrateMonoMp3,
      text: text);
  final ttsResponse = await AzureTts.getTts(params) as AudioSuccess;
  int result = await audioPlayer.playBytes(ttsResponse.audio);
  print("$result");
}

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
  late VoicesSuccess voicesResponse;

  //Get the audio bytes.

  // SpeechToText _speechToText = SpeechToText();
  // bool _speechEnabled = false;
  // String _lastWords = '';
  @override
  void initState() {
    super.initState();
    //SpeechToTextNotInitializedException();
    _speech = stt.SpeechToText();
    //initialiseTts();
  }

  //initialiseTts() async {}

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
        debugLogging: true,
      );
      if (available) {
        setState(() {
          this._isListening = true;
        });
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
      setState(() {
        this._isListening = false;
      });
      _speech.stop();
      messageController.clear();
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
      text_to_speech('Looks Like I have to study more...');
      return;
    }
    String txt = decodedData['answers'][0]['answer'];

    final urlRegExp = new RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    final urlMatches = urlRegExp.allMatches(txt);
    List<String> urls = urlMatches
        .map((urlMatch) => txt.substring(urlMatch.start, urlMatch.end))
        .toList();
    urls.forEach((x) => print(x));
    String anchor = "";
    String url_txt = "";
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
          url_txt = url_txt + txt[i];
          i++;
        }
      }
    }
    txt = txt.replaceAll(url_txt, "");
    txt = txt.replaceAll(anchor, "");
    txt = txt.replaceAll("[]()", "");
    // String clickable = extractLink()
    print("text=$txt");
    print("anchor=$anchor");
    print("url=$url");
    String audioText = anchor + txt;
    text_to_speech(audioText);
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
    ;
  }

  Widget chatBuilder() {
    return Container(
      //padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
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
              'Welcome!!!',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            trailing: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  textStyle: MaterialStateProperty.all(TextStyle(
                    color: Colors.white,
                  ))),
              onPressed: () => text_to_speech(_text),
              child: Icon(Icons.volume_up_outlined),
            ),
          ),
          Divider(
            height: 2.0,
          ),
          Container(
            //height: MediaQuery.of(context).size.height * 0.2,
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
                    if (message['sender'] == storage.getItem('user')['email'] ||
                        message['receiver'] == storage.getItem('user')['email'])
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
                  child: !_isListening ? Icon(Icons.mic) : Icon(Icons.close),
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
                    style: GoogleFonts.signika(
                        fontSize: 12.0, color: Colors.black),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(" "),
                  Text(
                    "$txt",
                    style: GoogleFonts.signika(
                        fontSize: 18.0, color: Colors.black),
                    maxLines: 20,
                  ),
                ],
              )),
        ),
      );
    }
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
    String audioText = anchor + txt;
    //text_to_speech(audioText);
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
