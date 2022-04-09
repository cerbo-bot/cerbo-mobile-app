import 'package:cerbo/ui/views/news/news_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/ui/widgets/alternate_homepage.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.initHome(),
      builder: (context, model, child) => Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: IconButton(
        //       icon: Icon(
        //         CupertinoIcons.info_circle,
        //       ),
        //       iconSize: 36,
        //       onPressed: model.openCerboWebsite),
        //   actions: [
        //     IconButton(
        //         icon: Icon(
        //           Icons.logout,
        //         ),
        //         iconSize: 36,
        //         onPressed: model.logout)
        //   ],
        // ),
        // backgroundColor: PrimaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: NewsView(),
          // child: BotHomeWidget(
          //   executeOperation: model.doSomething,
          //   userName: model.userName,
          // ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
