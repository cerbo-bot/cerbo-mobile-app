import 'package:flutter/material.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:my_bot/ui/widgets/chat_widget.dart';
import 'package:stacked/stacked.dart';

import 'chat_viewmodel.dart';

class ChatView extends StatelessWidget {
  const ChatView() : super();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatViewModel>.reactive(
      onModelReady: (model) => model.doSomething(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Chat",
            style: h3.copyWith(color: TextColorDark),
          ),
          leading: BackButton(
            color: TextColorDark,
          ),
        ),
        body: ChatWidget(),
      ),
      viewModelBuilder: () => ChatViewModel(),
    );
  }
}
