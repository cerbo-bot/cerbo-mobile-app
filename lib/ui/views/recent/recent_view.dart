import 'package:cerbo/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:cerbo/ui/widgets/cerbo_news_list.dart';
import 'package:cerbo/ui/widgets/cerbo_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentView extends StatelessWidget {
  final DashboardViewModel model;

  RecentView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: CerboTabBar(
            callBack: model.changeSelectedRecentTab,
            subcategories: model.recentCategories,
            isSmallTabBar: true,
            isLimitedWidget: true,
            initialSelectedCategory:
                model.selectedRecentTab ?? model.recentCategories.first,
          ),
        ),
        Flexible(
          flex: 13,
          child: model.selectedRecentTab?.name == "History"
              ? CerboNewsList(
                  model: model,
                  news: model.recentlyVisitedHistory,
                  cerboNewsListType: CerboNewsListType.HISTORY,
                )
              : model.selectedRecentTab?.name == "Read Later"
                  ? CerboNewsList(
                      model: model,
                      news: model.readLaterHistory,
                      cerboNewsListType: CerboNewsListType.READ_LATER,
                    )
                  : SizedBox(),
        )
      ],
    );
  }
}
