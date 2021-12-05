import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/ui/widgets/rotated_widget.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';

import 'news_viewmodel.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsViewModel>.reactive(
      onModelReady: (model) => model.getInitalStories(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Top Stories",
            style: subtitle1.copyWith(color: TextColorDark),
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
                  model.animationSyncButtonController?.rotate();
                },
              ),
              animationCallback: (animationCallback) {
                model.animationSyncButtonController = animationCallback;
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
                  child: ListView.separated(
                    itemCount: model.stories.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        onTap: () => model.openStory(model.stories[index].url),
                        onLongPress: () => {
                          model.share(model.stories[index].url.toString(),
                              subject: model.stories[index].title)
                        },
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(model.stories[index].title,
                              style: heading6.copyWith(color: TextColorDark)),
                        ),
                        subtitle: LinkPreview(
                          enableAnimation: true,
                          onPreviewDataFetched: (data) {
                            model.savePreviewData(data, index);
                          },
                          previewData: model.previewData[model.stories[index]
                              .url], // Pass the preview data from the state
                          text: model.stories[index].url,
                          textStyle: TextStyle(fontSize: 0, height: 0),
                          metadataTitleStyle: TextStyle(fontSize: 0, height: 0),
                          padding: const EdgeInsets.all(2),
                          width: MediaQuery.of(context).size.width,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: TextColorDark,
                    ),
                  ),
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
