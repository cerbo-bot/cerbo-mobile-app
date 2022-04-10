import 'package:cerbo/models/category.dart';
import 'package:cerbo/ui/widgets/cerbo_tab_bar_buttton.dart';
import 'package:flutter/material.dart';

class CerboTabBar extends StatefulWidget {
  final void Function(String)? callBack;
  final List<Category> subcategories;
  final bool isSmallTabBar;
  final bool isLimitedWidget;
  const CerboTabBar({
    Key? key,
    this.callBack,
    required this.subcategories,
    this.isSmallTabBar = false,
    this.isLimitedWidget = false,
  }) : super(key: key);

  @override
  State<CerboTabBar> createState() => _CerboTabBarState();
}

class _CerboTabBarState extends State<CerboTabBar> {
  var currentSelected = "";
  @override
  Widget build(BuildContext context) {
    if (widget.isLimitedWidget) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.subcategories.map((e) {
          if (e.name == null) {
            return SizedBox();
          }
          return CerboTabBarButton(
            currentSelected: currentSelected,
            changeSelectedTab: (name) {
              setState(() {
                currentSelected = name;
              });
              widget.callBack?.call(name);
            },
            name: e.name!,
            isSmallTabBar: widget.isSmallTabBar,
          );
        }).toList(),
      );
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (widget.subcategories[index].name == null) {
          return SizedBox();
        }
        return CerboTabBarButton(
          currentSelected: currentSelected,
          changeSelectedTab: (name) {
            setState(() {
              currentSelected = name;
            });
            widget.callBack?.call(name);
          },
          name: widget.subcategories[index].name!,
          isSmallTabBar: widget.isSmallTabBar,
        );
      },
      itemCount: widget.subcategories.length,
      separatorBuilder: (context, index) => SizedBox(
        width: 10,
      ),
    );
  }
}
