import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/models/category.dart';
import 'package:cerbo/ui/re_usable_functions.dart';
import 'package:flutter/material.dart';

class CerboTabBarButton extends StatelessWidget {
  final void Function(Category)? changeSelectedTab;
  final Category? currentSelected;
  final Category category;
  final bool isSmallTabBar;
  const CerboTabBarButton(
      {Key? key,
      required this.currentSelected,
      required this.category,
      this.changeSelectedTab,
      this.isSmallTabBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (category.name?.isEmpty == false) {
      return Column(
        children: [
          Flexible(
            flex: 5,
            child: TextButton(
              onPressed: () => {changeSelectedTab?.call(category)},
              child: Text(
                capitailze(category.name!),
                style: isSmallTabBar
                    ? currentSelected?.name?.toLowerCase() ==
                            category.name!.toLowerCase()
                        ? heading6Bold
                        : heading6Light
                    : currentSelected?.name?.toLowerCase() ==
                            category.name!.toLowerCase()
                        ? heading5Bold
                        : heading5Light,
              ),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Grey),
              ),
            ),
          ),
          (isSmallTabBar && currentSelected == category)
              ? Flexible(
                  flex: 1,
                  child: Container(
                    width: ((category.name!.length) * 10).toDouble(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blueAccent,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
