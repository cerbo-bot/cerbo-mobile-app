import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/models/categories.dart';
import 'package:cerbo/models/news.dart';
import 'package:cerbo/ui/views/home/recent/recent_view.dart';
import 'package:cerbo/ui/widgets/cerbo_carousal_list.dart';
import 'package:cerbo/ui/widgets/cerbo_category_cards.dart';
import 'package:cerbo/ui/widgets/cerbo_news_list.dart';
import 'package:cerbo/ui/widgets/cerbo_tab_bar.dart';
import 'package:cerbo/ui/widgets/cerbo_tab_bar_buttton.dart';
import 'package:cerbo/ui/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double carousalWidth = width - 32;
    double carousalHeight = height / 3;
    double regionalTabViewHeight = height / 14;
    double regionalNewsViewHeight =
        height - (carousalHeight + 150 + regionalTabViewHeight);

    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.initHome(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.menu,
              ),
              onPressed: model.openCerboWebsite),
          actions: [
            IconButton(
              onPressed: model.doSomething,
              icon: Icon(
                Icons.ac_unit_outlined,
                color: Colors.black,
              ),
            ),
            IconButton(
                icon: Icon(
                  CupertinoIcons.search,
                  color: Colors.black,
                ),
                onPressed: model.search),
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onPressed: model.logout)
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: CerboTabBar(
                  subcategories: model.mainCategories,
                  isLimitedWidget: true,
                  callBack: model.changeSelectedCategoryTab,
                  initialSelectedCategory: model.selectedCategoryTab,
                ),
              ),
              model.selectedCategoryTab?.name == "Popular"
                  ? Flexible(
                      flex: 13,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CerboCategoryCard(
                                  category: model.categories[index],
                                );
                              },
                              itemCount: model.categories.length,
                            ),
                          ),
                          Flexible(
                            child: CerboCarousalList(newsList: model.news),
                            flex: 3,
                          ),
                          Flexible(
                            child: CerboTabBar(
                              subcategories: model.categories,
                              isSmallTabBar: true,
                              initialSelectedCategory:
                                  model.selectedRegionalTab,
                              callBack: model.changeSelectedRegionalNewsTab,
                            ),
                            flex: 1,
                          ),
                          Flexible(
                            child:
                                CerboNewsList(model: model, news: model.news),
                            flex: 7,
                          )
                        ],
                      ),
                    )
                  : model.selectedCategoryTab?.name == "Recent"
                      ? Flexible(
                          child: RecentView(
                            model: model,
                          ),
                          flex: 13,
                        )
                      : SizedBox(),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
