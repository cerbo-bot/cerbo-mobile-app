import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/models/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../re_usable_functions.dart';

class NewsCard extends StatelessWidget {
  final News? news;
  final Function addToHistory;
  final Function addToReadLater;
  final Function removeNewsFromHistory;
  final bool shouldShowReadLater;

  const NewsCard(
      {Key? key,
      this.news,
      required this.addToHistory,
      required this.addToReadLater,
      required this.removeNewsFromHistory,
      this.shouldShowReadLater = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double newsEdgeRadius = 16;
    double newsCardLeftPadding = 8;
    double newsCardMargin = 4;
    double newsCardLeadingPadding = 14;
    double newsCardHeight = MediaQuery.of(context).size.height / 5.5;
    double newsCardWidth = MediaQuery.of(context).size.width;
    double newsCardImageHeight = (newsCardWidth / 6) > (newsCardHeight - 38)
        ? (newsCardHeight - 38)
        : (newsCardWidth / 4);
    double newsCardImageWidth = newsCardImageHeight / 1.5;
    double newsRemainingWidth = newsCardWidth -
        (newsCardImageWidth +
            newsCardLeftPadding +
            (newsCardMargin * 2) +
            (newsCardLeadingPadding * 2) +
            4);
    return GestureDetector(
      onTap: () {
        try {
          addToHistory(this.news);
          launchUrl(news?.link ?? "");
        } catch (exception) {
          showSnakBar(context, "Unable to open this article");
        }
      },
      onLongPress: () {
        share(
            title: news?.title ?? "",
            subject: news?.description ?? "",
            message: news?.link ?? "");
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: newsCardMargin),
        height: newsCardHeight,
        width: newsCardWidth,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(newsEdgeRadius),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: newsCardLeftPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(newsEdgeRadius),
                  child: Image.network(
                    news?.img ??
                        "https://images.financialexpress.com/2021/10/Nissan-Magnite.jpg?w=692",
                    height: newsCardImageHeight,
                    width: newsCardImageWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(newsCardLeadingPadding),
                  width: newsRemainingWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news?.title ?? "",
                        style: body2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        news?.description ?? "",
                        style: heading7.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time_sharp,
                              size: 16,
                              color: TextColorUnSelected,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "${getTimeInString((news?.readTime) ?? 0)}",
                              style: body2.copyWith(color: TextColorUnSelected),
                            ),
                            SizedBox(width: 12),
                            shouldShowReadLater
                                ? Icon(
                                    CupertinoIcons.eyeglasses,
                                    size: 16,
                                    color: TextColorUnSelected,
                                  )
                                : Icon(
                                    CupertinoIcons.delete,
                                    size: 16,
                                    color: TextColorUnSelected,
                                  ),
                            SizedBox(width: 8),
                            shouldShowReadLater
                                ? GestureDetector(
                                    onTap: () {
                                      addToReadLater(this.news);
                                    },
                                    child: Text(
                                      "Read later",
                                      style: body2.copyWith(
                                          color: TextColorUnSelected),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      removeNewsFromHistory(this.news);
                                    },
                                    child: Text(
                                      "Remove",
                                      style: body2.copyWith(
                                          color: TextColorUnSelected),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
