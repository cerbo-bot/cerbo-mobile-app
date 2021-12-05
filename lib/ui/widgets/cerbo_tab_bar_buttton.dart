import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/ui/re_usable_functions.dart';
import 'package:flutter/material.dart';

class CerboTabBarButton extends StatelessWidget {
  final Function changeSelectedTab;
  final String currentSelected;
  final String name;
  final bool isSmallTabBar;
  const CerboTabBarButton(
      {Key? key,
      required this.currentSelected,
      required this.changeSelectedTab,
      required this.name,
      this.isSmallTabBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => {changeSelectedTab(name)},
          child: Text(
            capitailze(name),
            style: isSmallTabBar
                ? currentSelected.toLowerCase() == name.toLowerCase()
                    ? heading6.copyWith(fontWeight: FontWeight.bold)
                    : heading6.copyWith(color: TextColorUnSelected)
                : currentSelected.toLowerCase() == name.toLowerCase()
                    ? heading5.copyWith(fontWeight: FontWeight.bold)
                    : heading5.copyWith(color: TextColorUnSelected),
          ),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Grey),
          ),
        ),
        (isSmallTabBar && currentSelected == name)
            ? Container(
                height: 6,
                width: ((name.length) * 10).toDouble(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blueAccent,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
