import 'package:cerbo/models/news.dart';
import 'package:cerbo/ui/views/home/home_viewmodel.dart';
import 'package:cerbo/ui/widgets/news_card.dart';
import 'package:flutter/widgets.dart';

enum CerboNewsListType { HISTORY, NORMAL, READ_LATER }

class CerboNewsList extends StatelessWidget {
  final HomeViewModel model;
  final List<News> news;
  final cerboNewsListType;
  const CerboNewsList(
      {Key? key,
      required this.model,
      required this.news,
      this.cerboNewsListType = CerboNewsListType.NORMAL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (news.isEmpty) {
            return SizedBox();
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: constraints.maxWidth,
                height: constraints.maxWidth / 3.5,
                child: NewsCard(
                  news: news[index],
                  addToHistory: model.addNewsToHistory,
                  addToReadLater: model.addNewsToReadLater,
                  removeNewsFromHistory: model.removeNewsToHistory,
                  removeNewsFromReadLater: model.removeNewsToReadLater,
                  cerboNewsListType: cerboNewsListType,
                  shouldShowReadLater: ([
                    CerboNewsListType.HISTORY,
                    CerboNewsListType.READ_LATER
                  ].contains(cerboNewsListType))
                      ? false
                      : true,
                ),
              );
            },
            itemCount: news.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: constraints.maxWidth / 24);
            },
          );
        },
      ),
    );
  }
}
