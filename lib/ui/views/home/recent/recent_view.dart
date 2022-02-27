import 'package:cerbo/models/news.dart';
import 'package:cerbo/ui/views/home/home_viewmodel.dart';
import 'package:cerbo/ui/widgets/cerbo_tab_bar_buttton.dart';
import 'package:cerbo/ui/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentView extends StatelessWidget {
  final double height;
  final double width;
  final HomeViewModel model;

  const RecentView(
      {Key? key,
      required this.height,
      required this.width,
      required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CerboTabBarButton(
              currentSelected: model.selectedRecentTab,
              changeSelectedTab: model.changeSelectedRecentTab,
              name: "Read Later",
              isSmallTabBar: true,
            ),
            CerboTabBarButton(
              currentSelected: model.selectedRecentTab,
              changeSelectedTab: model.changeSelectedRecentTab,
              name: "History",
              isSmallTabBar: true,
            )
          ],
        ),
        Container(
          height: height,
          width: width,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return NewsCard(
                shouldShowReadLater: false,
                removeNewsFromHistory: model.selectedRecentTab == "History"
                    ? model.removeNewsToHistory
                    : model.removeNewsToReadLater,
                addToReadLater: (News? news) {},
                addToHistory: (News? news) {},
                news: model.selectedRecentTab == "History"
                    ? model.recentlyVisitedHistory[index]
                    : model.readLaterHistory[index],
              );
            },
            itemCount: model.selectedRecentTab == "History"
                ? model.recentlyVisitedHistory.length
                : model.readLaterHistory.length,
          ),
        )
      ],
    );
  }
}
