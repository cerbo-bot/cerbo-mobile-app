import 'package:cerbo/models/news_list.dart';
import 'package:cerbo/services/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../re_usable_functions.dart';

class CerboCarousal extends StatelessWidget {
  final NewsList? newsList;
  final double carousalHeight;
  final double carousalWidth;
  final ScrollController _controller = ScrollController();
  final animationDuration = Duration(milliseconds: 500);
  CerboCarousal({
    Key? key,
    required this.newsList,
    this.carousalHeight = 0,
    this.carousalWidth = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      physics: PageScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                try {
                  launchUrl(newsList?.newsList?[index].link ?? "");
                } catch (exception) {
                  showSnakBar(context, "Can't open this article");
                }
              },
              onLongPress: () {
                // share(
                //     title: news?.title ?? "",
                //     subject: news?.description ?? "",
                //     message: news?.link ?? "");
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  newsList?.newsList?[index].img ??
                      "https://images.financialexpress.com/2021/10/Nissan-Magnite.jpg?w=692",
                  height: carousalHeight,
                  width: carousalWidth,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: carousalWidth,
                height: carousalHeight,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.chevron_left_sharp),
                  onPressed: () {
                    double nextLocation =
                        _controller.position.pixels - carousalWidth;
                    if (nextLocation < 0) {
                      _controller.animateTo(
                        _controller.position.maxScrollExtent,
                        duration: animationDuration,
                        curve: Curves.decelerate,
                      );
                    } else {
                      _controller.animateTo(
                        nextLocation,
                        duration: animationDuration,
                        curve: Curves.decelerate,
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: carousalWidth,
                height: carousalHeight,
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.chevron_right_sharp),
                  onPressed: () {
                    double nextLocation =
                        _controller.position.pixels + carousalWidth;
                    if (nextLocation > _controller.position.maxScrollExtent) {
                      _controller.animateTo(
                        _controller.position.minScrollExtent,
                        duration: animationDuration,
                        curve: Curves.decelerate,
                      );
                    } else {
                      _controller.animateTo(
                        nextLocation,
                        duration: animationDuration,
                        curve: Curves.decelerate,
                      );
                    }
                  },
                ),
              ),
            )
            // Positioned(
            //   child: Container(
            //     width: carousalWidth - 16,
            //     height: carousalHeight / 2,
            //     alignment: Alignment.bottomLeft,
            //     child: Text(
            //       newsList?.newsList?[index].title ?? "",
            //       style: heading6,
            //     ),
            //   ),
            //   bottom: 8,
            //   left: 08,
            // )
          ],
        );
      },
      itemCount: newsList?.newsList?.length ?? 0,
    );
  }
}
