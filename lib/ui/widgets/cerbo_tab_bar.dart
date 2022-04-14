import 'package:cerbo/models/category.dart';
import 'package:cerbo/ui/widgets/cerbo_tab_bar_buttton.dart';
import 'package:flutter/material.dart';

class CerboTabBar extends StatefulWidget {
  final void Function(Category)? callBack;
  final List<Category> subcategories;
  final bool isSmallTabBar;
  final bool isLimitedWidget;
  final Category? initialSelectedCategory;
  const CerboTabBar(
      {Key? key,
      this.callBack,
      required this.subcategories,
      this.isSmallTabBar = false,
      this.isLimitedWidget = false,
      this.initialSelectedCategory})
      : super(key: key);

  @override
  State<CerboTabBar> createState() => _CerboTabBarState();
}

class _CerboTabBarState extends State<CerboTabBar> {
  Category? currentSelected;
  @override
  Widget build(BuildContext context) {
    if (widget.isLimitedWidget) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.subcategories.map((e) {
          if (e.name == null) {
            return SizedBox();
          }
          return CerboTabBarButton(
            currentSelected: currentSelected ?? widget.initialSelectedCategory,
            changeSelectedTab: (name) {
              setState(() {
                currentSelected = e;
              });
              widget.callBack?.call(e);
            },
            category: e,
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
          currentSelected: currentSelected ?? widget.initialSelectedCategory,
          changeSelectedTab: (name) {
            setState(() {
              currentSelected = widget.subcategories[index];
            });
            widget.callBack?.call(widget.subcategories[index]);
          },
          category: widget.subcategories[index],
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
