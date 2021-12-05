import 'package:cerbo/ui/widgets/cerbo_carousal.dart';
import 'package:cerbo/ui/widgets/cerbo_tab_bar_buttton.dart';
import 'package:cerbo/ui/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cerbo/constants/styles.dart';
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
      builder: (context, model, child) => DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: SecondaryColor,
            child: Icon(
              Icons.chat_bubble_outline,
              color: PrimaryColor,
            ),
            onPressed: model.openChatPage,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CerboTabBarButton(
                        name: "Popular",
                        currentSelected: model.selectedCategoryTab,
                        changeSelectedTab: model.changeSelectedCategoryTab,
                      ),
                      CerboTabBarButton(
                        name: "Trending",
                        currentSelected: model.selectedCategoryTab,
                        changeSelectedTab: model.changeSelectedCategoryTab,
                      ),
                      CerboTabBarButton(
                        name: "Recent",
                        currentSelected: model.selectedCategoryTab,
                        changeSelectedTab: model.changeSelectedCategoryTab,
                      ),
                    ],
                  ),
                  Container(
                    height: carousalHeight,
                    width: carousalWidth,
                    child: CerboCarousal(
                        newsList: (model.selectedCategoryTab.toLowerCase() ==
                                "popular"
                            ? model.categoriesCache?.popular?.carousel
                            : model.selectedCategoryTab.toLowerCase() ==
                                    "recent"
                                ? model.categoriesCache?.recent?.carousel
                                : model.categoriesCache?.trending?.carousel),
                        carousalHeight: carousalHeight,
                        carousalWidth: carousalWidth),
                  ),
                  Container(
                    height: regionalTabViewHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CerboTabBarButton(
                          isSmallTabBar: true,
                          currentSelected: model.selectedRegionalTab,
                          changeSelectedTab:
                              model.changeSelectedRegionalNewsTab,
                          name: (model.selectedCategoryTab.toLowerCase() ==
                                      "popular"
                                  ? model.categoriesCache?.popular?.regionalNews
                                      ?.keys
                                      ?.toList()[index]
                                  : model.selectedCategoryTab.toLowerCase() ==
                                          "recent"
                                      ? model.categoriesCache?.recent
                                          ?.regionalNews?.keys
                                          .toList()[index]
                                      : model.categoriesCache?.trending
                                          ?.regionalNews?.keys
                                          .toList()[index]) ??
                              "-----",
                        );
                      },
                      itemCount:
                          (model.selectedCategoryTab.toLowerCase() == "popular"
                                  ? model.categoriesCache?.popular?.regionalNews
                                      ?.keys.length
                                  : model.selectedCategoryTab.toLowerCase() ==
                                          "recent"
                                      ? model.categoriesCache?.recent
                                          ?.regionalNews?.keys.length
                                      : model.categoriesCache?.trending
                                          ?.regionalNews?.keys.length) ??
                              0,
                    ),
                  ),
                  model.selectedRegionalTab.length > 0
                      ? Container(
                          height: regionalNewsViewHeight,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return NewsCard(
                                  news: (model.selectedCategoryTab
                                              .toLowerCase() ==
                                          "popular"
                                      ? (model
                                          .categoriesCache
                                          ?.popular
                                          ?.regionalNews?[
                                              model.selectedRegionalTab]
                                          ?.newsList?[index])
                                      : model.selectedCategoryTab
                                                  .toLowerCase() ==
                                              "recent"
                                          ? (model
                                              .categoriesCache
                                              ?.recent
                                              ?.regionalNews?[
                                                  model.selectedRegionalTab]
                                              ?.newsList?[index])
                                          : (model
                                              .categoriesCache
                                              ?.trending
                                              ?.regionalNews?[
                                                  model.selectedRegionalTab]
                                              ?.newsList?[index])));
                            },
                            itemCount: (model.selectedCategoryTab
                                            .toLowerCase() ==
                                        "popular"
                                    ? (model
                                        .categoriesCache
                                        ?.popular
                                        ?.regionalNews?[
                                            model.selectedRegionalTab]
                                        ?.newsList
                                        ?.length)
                                    : model.selectedCategoryTab.toLowerCase() ==
                                            "recent"
                                        ? (model
                                            .categoriesCache
                                            ?.recent
                                            ?.regionalNews?[
                                                model.selectedRegionalTab]
                                            ?.newsList
                                            ?.length)
                                        : (model
                                            .categoriesCache
                                            ?.trending
                                            ?.regionalNews?[
                                                model.selectedRegionalTab]
                                            ?.newsList
                                            ?.length)) ??
                                0,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
