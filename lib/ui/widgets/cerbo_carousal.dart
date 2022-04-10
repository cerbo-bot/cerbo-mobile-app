import 'dart:developer';

import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/models/news.dart';
import 'package:cerbo/services/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../re_usable_functions.dart';

class CerboCarousal extends StatelessWidget {
  final List<News>? newsList;
  final ScrollController _controller = ScrollController();
  CerboCarousal({
    Key? key,
    required this.newsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(newsList?.length);
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
        controller: _controller,
        physics: PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(
                    newsList?[index]?.image ??
                        "https://www.pngitem.com/pimgs/m/108-1086648_naruto-png-transparent-png.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: newsList?.length ?? 0,
      );
    });
  }
}
