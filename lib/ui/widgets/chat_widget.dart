import 'package:flutter/material.dart';
import 'package:cerbo/ui/widgets/chat/chat.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatWidget extends StatelessWidget {
  final types.Room room;
  ChatWidget({required this.room});

  @override
  Widget build(BuildContext context) {
    return ChatPage(room: room);
  }
}
