import 'package:flutter/material.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

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
    }
  }

  /// This has to happen only once per app
  // void _initSpeech() async {
  //   _speechEnabled = await _speechToText.initialize();
  //   setState(() {});
  // }

  // /// Each time to start a speech recognition session
  // void _startListening() async {
  //   await _speechToText.listen(onResult: _onSpeechResult);
  //   setState(() {});
  // }

  // /// Manually stop the active speech recognition session
  // /// Note that there are also timeouts that each platform enforces
  // /// and the SpeechToText plugin supports setting timeouts on the
  // /// listen method.
  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {});
  // }

  // /// This is the callback that the SpeechToText plugin calls when
  // /// the platform returns recognized words.
  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   print('in speech to text');
  //   print(result.recognizedWords);
  //   setState(() {
  //     _lastWords = result.recognizedWords;
  //   });
  // }

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
    TextEditingController messageController = TextEditingController();
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
          SizedBox(
            height: 370.0,
          ),
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
                  child: Icon(Icons.mic),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.send),
              ),
            ],
          )
        ],
      ),
    );
  }
}
// class chatBuilder extends StatefulWidget {
//   chatBuilder({Key? key}) : super(key: key);

//   @override
//   State<chatBuilder> createState() => _chatBuilderState();
// }

// class _chatBuilderState extends State<chatBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

