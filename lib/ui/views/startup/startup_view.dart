import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:my_bot/ui/widgets/bothome.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  const StartUpView() : super();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(
                  CupertinoIcons.info_circle,
                ),
                iconSize: 36,
                onPressed: model.openCerboWebsite)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: SecondaryColor,
          child: Icon(
            Icons.chat_bubble_outline,
            color: PrimaryColor,
          ),
          onPressed: model.openChatPage,
        ),
        backgroundColor: PrimaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: BotHomeWidget(executeOperation: model.doSomething),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
