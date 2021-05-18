import 'package:flutter/material.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:my_bot/ui/widgets/chat_widget.dart';
import 'package:stacked/stacked.dart';

import 'chat_viewmodel.dart';

class ChatView extends StatelessWidget {
  final String roomId;
  const ChatView({required this.roomId});

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
            style: h3.copyWith(color: TextColorDark),
          ),
          leading: BackButton(
            color: TextColorDark,
          ),
        ),
        body: ChatWidget(
          roomId: roomId,
        ),
      ),
      viewModelBuilder: () => ChatViewModel(),
    );
  }
}
