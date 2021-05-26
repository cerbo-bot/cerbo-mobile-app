import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/ui/widgets/bothome.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.initHome(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                CupertinoIcons.info_circle,
              ),
              iconSize: 36,
              onPressed: model.openCerboWebsite),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.logout,
                ),
                iconSize: 36,
                onPressed: model.logout)
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
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
