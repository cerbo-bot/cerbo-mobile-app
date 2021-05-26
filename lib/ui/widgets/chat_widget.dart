import 'package:flutter/material.dart';
import 'package:cerbo/ui/widgets/chat/chat.dart';

class ChatWidget extends StatelessWidget {
  final String roomId;
  ChatWidget({required this.roomId});

  @override
  Widget build(BuildContext context) {
    return ChatPage(roomId: roomId);
  }
}
