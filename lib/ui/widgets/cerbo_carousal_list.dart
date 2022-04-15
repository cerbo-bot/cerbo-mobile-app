import 'dart:developer';

import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/models/news.dart';
import 'package:cerbo/services/common.dart';
import 'package:cerbo/ui/widgets/carousal_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../re_usable_functions.dart';

class CerboCarousalList extends StatelessWidget {
  final List<News>? newsList;
  final ScrollController _controller = ScrollController();
  CerboCarousalList({
    Key? key,
    required this.newsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(newsList?.length);
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.builder(
          controller: _controller,
          physics: PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: CerboCarouselCard(news: newsList?[index]));
          },
          itemCount: newsList?.length ?? 0,
        );
      },
    );
  }
}
