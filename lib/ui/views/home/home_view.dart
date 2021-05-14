import 'package:flutter/material.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:my_bot/ui/widgets/animated_sync.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  AnimationSyncButtonController? _animationSyncButtonController;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.doSomething(),
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
            AnimatedSyncButton(onPressedButton: () {
              model.doSomething();
            }, animationCallback: (animationCallback) {
              _animationSyncButtonController = animationCallback;
            })
          ],
        ),
        body: model.stories.length == 0
            ? model.loader
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: model.stories.length,
                  itemBuilder: (_, index) {
                    try {
                      _animationSyncButtonController?.stopAnimation();
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
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
