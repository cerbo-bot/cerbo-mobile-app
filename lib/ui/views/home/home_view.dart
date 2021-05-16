import 'package:flutter/material.dart';
import 'package:my_bot/app/app.locator.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:my_bot/ui/widgets/rotated_widget.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  AnimationSyncButtonController? _animationSyncButtonController;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.getInitalStories(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Top Stories",
              style: h3.copyWith(color: TextColorDark),
            ),
            leading: BackButton(
              color: TextColorDark,
            ),
            actions: [
              RotatedWidget(
                widgetToAnimate: IconButton(
                  icon: Icon(
                    Icons.cached_rounded,
                    color: TextColorDark,
                  ),
                  onPressed: () {
                    model.getStoriesAndCache();
                    _animationSyncButtonController?.rotate();
                  },
                ),
                animationCallback: (animationCallback) {
                  _animationSyncButtonController = animationCallback;
                },
              )
            ],
          ),
          body: model.stories.length == 0
              ? model.loader
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        model.getNext();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: model.stories.length,
                      itemBuilder: (_, index) {
                        try {
                          _animationSyncButtonController?.stop();
                        } catch (exception) {}
                        return ListTile(
                          onTap: () {
                            model.openStory(model.stories[index].url);
                          },
                          title: Text(model.stories[index].title,
                              style: h4.copyWith(color: TextColorDark)),
                          subtitle: Text(model.stories[index].by),
                        );
                      },
                    ),
                  ),
                ),
          bottomNavigationBar: model.showBottomBarText
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Loading more stories ..."),
                  ],
                )
              : null),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
