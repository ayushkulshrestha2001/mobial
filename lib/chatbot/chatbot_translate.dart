import 'package:flutter/material.dart';
import 'package:mobial/chatbot/chatbot.dart';

class TranslatedChatbot extends StatefulWidget {
  final List<ChatbotMessage> messages;
  final String language;
  TranslatedChatbot({required this.messages, required this.language});
  @override
  _TranslatedChatbotState createState() =>
      _TranslatedChatbotState(messages: messages, language: this.language);
}

class _TranslatedChatbotState extends State<TranslatedChatbot> {
  final List<ChatbotMessage> messages;
  String language;
  _TranslatedChatbotState({required this.messages, required this.language});
  List<ChatbotMessage> finalMessages = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      finalMessages = messages;
    });
    _showLanguages();
  }

  _showLanguages() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Stack(children: [
          AlertDialog(
            title: const Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd5e4e1),
      appBar: AppBar(
        title: Text("Chat translated to $language"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            finalMessages.clear();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        reverse: true,
        padding: EdgeInsets.zero,
        children: finalMessages,
      ),
    );
  }
}
