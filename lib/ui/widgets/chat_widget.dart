import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:my_bot/app/app.locator.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:my_bot/services/api.dart';

class ChatWidget extends StatefulWidget {
  ChatWidget({Key? key}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');
  final _user2 = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666d');

  String randomString() {
    var random = Random.secure();
    var values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      authorId: _user.id,
      id: randomString(),
      text: message.text,
      timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
    );

    _addMessage(textMessage);
    _getReply();
  }

  void _getReply() async {
    final responses = await locator<APIService>().randomAdvice();
    final textMessage = types.TextMessage(
        authorId: _user2.id, id: randomString(), text: responses.slip.advice);
    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      messages: _messages,
      onSendPressed: _handleSendPressed,
      user: _user,
      theme: DefaultChatTheme(
          backgroundColor: SecondaryColor,
          body1: body,
          body2: caption,
          inputBackgroundColor: PrimaryColor,
          inputBorderRadius: BorderRadius.zero,
          primaryColor: PrimaryColor),
    );
  }
}
