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
