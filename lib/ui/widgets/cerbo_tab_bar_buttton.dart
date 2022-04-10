import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/ui/re_usable_functions.dart';
import 'package:flutter/material.dart';

class CerboTabBarButton extends StatelessWidget {
  final void Function(String)? changeSelectedTab;
  final String currentSelected;
  final String name;
  final bool isSmallTabBar;
  const CerboTabBarButton(
      {Key? key,
      required this.currentSelected,
      required this.name,
      this.changeSelectedTab,
      this.isSmallTabBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 5,
          child: TextButton(
            onPressed: () => {changeSelectedTab?.call(name)},
            child: Text(
              capitailze(name),
              style: isSmallTabBar
                  ? currentSelected.toLowerCase() == name.toLowerCase()
                      ? heading6.copyWith(fontWeight: FontWeight.bold)
                      : heading6.copyWith(color: TextColorUnSelected)
                  : currentSelected.toLowerCase() == name.toLowerCase()
                      ? heading5.copyWith(fontWeight: FontWeight.bold)
                      : heading5.copyWith(
                          color: TextColorUnSelected,
                        ),
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Grey),
            ),
          ),
        ),
        (isSmallTabBar && currentSelected == name)
            ? Flexible(
                flex: 1,
                child: Container(
                  width: ((name.length) * 10).toDouble(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blueAccent,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
