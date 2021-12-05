import 'package:flutter/material.dart';
import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/ui/widgets/chat_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'chat_viewmodel.dart';

class ChatView extends StatelessWidget {
  final types.Room room;
  const ChatView({required this.room});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      onModelReady: (model) => model.doSomething(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: SecondaryColor,
          elevation: 0,
          title: Text(
            "Ask Cerbo",
            style: subtitle1.copyWith(color: TextColorDark),
          ),
          leading: BackButton(
            color: TextColorDark,
          ),
        ),
        body: ChatWidget(
          room: room,
        ),
      ),
      viewModelBuilder: () => ChatViewModel(),
    );
  }
}
