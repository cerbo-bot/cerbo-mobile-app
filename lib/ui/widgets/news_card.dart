import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/models/news.dart';
import 'package:cerbo/ui/widgets/cerbo_category_cards.dart';
import 'package:cerbo/ui/widgets/cerbo_news_list.dart';
import 'package:cerbo/ui/widgets/read_later_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../re_usable_functions.dart';

class NewsCard extends StatelessWidget {
  final News? news;
  final void Function(News) addToHistory;
  final void Function(News) addToReadLater;
  final void Function(News) removeNewsFromHistory;
  final void Function(News) removeNewsFromReadLater;
  final CerboNewsListType cerboNewsListType;
  final bool shouldShowReadLater;

  const NewsCard(
      {Key? key,
      this.news,
      required this.addToHistory,
      required this.addToReadLater,
      required this.removeNewsFromHistory,
      this.shouldShowReadLater = true,
      required this.removeNewsFromReadLater,
      required this.cerboNewsListType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          try {
            if (this.news != null) {
              addToHistory(this.news!);
              launchUrl(news?.link ?? "");
            }
          } catch (exception) {
            showSnakBar(context, "Unable to open this article");
          }
        },
        onLongPress: () {
          share(
              title: news?.title ?? "",
              subject: news?.content ?? "",
              message: news?.link ?? "");
        },
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          news?.image ??
                              "https://www.pngitem.com/pimgs/m/108-1086648_naruto-png-transparent-png.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            news?.title ?? "",
                            style: body2Title,
                          ),
                          flex: 1,
                        ),
                        Flexible(
                          child: Text(
                            news?.text ?? "",
                            style: subtitle1,
                            maxLines: 2,
                          ),
                          flex: 2,
                        ),
                        Flexible(
                          child: ReadLaterWidget(
                              addToReadLater: addToReadLater,
                              news: news,
                              shouldShowReadLater: shouldShowReadLater,
                              removeNewsFromHistory: cerboNewsListType ==
                                      CerboNewsListType.READ_LATER
                                  ? removeNewsFromReadLater
                                  : removeNewsFromHistory),
                          flex: 1,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
