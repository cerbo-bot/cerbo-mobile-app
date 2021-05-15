import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView() : super();

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
            IconButton(
                icon: Icon(
                  Icons.cached_rounded,
                  color: TextColorDark,
                ),
                onPressed: () => model.doSomething())
          ],
        ),
        body: model.stories.length == 0
            ? model.loader
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: model.stories.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      onTap: () => model.openStory(model.stories[index].url),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(model.stories[index].title,
                            style: h4.copyWith(color: TextColorDark)),
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
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
