import 'package:flutter/material.dart';
import 'package:mobial/chat_screen.dart';

class TranslatedChat extends StatefulWidget {
  final List<ChatMessage> messages;
  final String language;
  TranslatedChat({required this.messages, required this.language});
  @override
  _TranslatedChatState createState() =>
      _TranslatedChatState(messages: messages, language: language);
}

class _TranslatedChatState extends State<TranslatedChat> {
  final List<ChatMessage> messages;
  final String language;
  _TranslatedChatState({required this.messages, required this.language});
  List<ChatMessage> finalMessages = [];
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
