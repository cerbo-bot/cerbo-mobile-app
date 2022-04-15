import 'package:cerbo/ui/widgets/alternate_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/ui/widgets/rotated_widget.dart';
import 'package:stacked/stacked.dart';

import 'news_viewmodel.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsViewModel>.reactive(
      onModelReady: (model) => model.getInitalStories(),
      builder: (context, model, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Top Stories",
            style: h3.copyWith(color: TextColorDark),
          ),
          // leading: BackButton(
          //   color: TextColorLight,
          // ),
          actions: [
            RotatedWidget(
              widgetToAnimate: IconButton(
                icon: Icon(
                  FeatherIcons.refreshCcw,
                  color: TextColorLight,
                ),
                onPressed: () {
                  model.getStoriesAndCache();
                  model.animationSyncButtonController?.rotate();
                },
              ),
              animationCallback: (animationCallback) {
                model.animationSyncButtonController = animationCallback;
              },
            )
          ],
        ),
        body: model.stories!.length == 0
            ? model.loader
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    model.getNext();
                  }
                  return true;
                },
                child: PageView.builder(
                  itemCount: model.stories!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) {
                    return NewsItemWidget(
                      title: model.stories![index].title!,
                      description: model.stories![index].content!,
                      image: model.stories![index].image!,
                      url: model.stories![index].url!,
                      categories: model.stories![index].categories!,
                      action: () {
                        model.share(model.stories![index].url!,
                            subject: model.stories![index].title!);
                      },
                    );
                  },
                ),
              ),
        bottomNavigationBar: model.showBottomBarText
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Loading more stories ...",
                      style: heading6.copyWith(
                          color: TextColorDark, fontSize: 12)),
                ],
              )
            : null,
      ),
      viewModelBuilder: () => NewsViewModel(),
    );
  }
}
