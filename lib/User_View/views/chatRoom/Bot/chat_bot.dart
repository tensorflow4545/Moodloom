import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:HappyLink/data/baseApi.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  void initState() {
    super.initState();
    sendMessageToChatGpt();
  }

  void sendMessageToChatGpt() async {
    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": "hello"}
      ],
      "max_tokens": 500
    };

    ;

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Urls.apiKey}"
      },
      body: json.encode(body),
    );

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
