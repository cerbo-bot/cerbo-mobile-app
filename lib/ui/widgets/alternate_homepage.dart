import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.router.dart';
import 'package:cerbo/services/common.dart';
import 'package:cerbo/ui/widgets/highlighter.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:cerbo/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stacked_services/stacked_services.dart';

final RegExp numberRegex = RegExp(r"(-?\d*\.{0,1}\d+)");
final _nagivationService = locator<NavigationService>();

List<Widget> getCategories(List<String> categories) {
  List<Widget> categoryWidgets = [];

  categories
      .map(
        (e) => categoryWidgets.add(
          Chip(
            label: Text(e, style: TextStyle(color: TextColorDark)),
            backgroundColor: TextColorLight2,
          ),
        ),
      )
      .toList();
  return categoryWidgets;
}

class NewsItemWidget extends StatelessWidget {
  final String title, description, image, url;
  final Function action;
  final List<String> categories;
  const NewsItemWidget(
      {required this.title,
      required this.description,
      required this.image,
      required this.url,
      required this.action,
      required this.categories});

  openStory(String url) async {
    try {
      await locator<CommonServices>().launchUrl(url);
    } catch (e) {}
  }

  getIcon(String category) {
    switch (category) {
      case "business":
        return FeatherIcons.briefcase;
      case "entertainment":
        return FeatherIcons.tv;
      case "general":
        return FeatherIcons.globe;
      case "health":
        return FeatherIcons.heart;
      case "science":
        return Icons.science;
      case "sports":
        return Icons.sports_football_outlined;
      case "technology":
        return FeatherIcons.cpu;
      default:
        return FeatherIcons.activity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        // open story when user starts dragging left
        // and open call navigateToDashboard when user starts dragging right
        if (details.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
          openStory(url);
        } else {
          navigateToDashboard();
        }
      },
      child: Stack(
        children: [
          Image.network(
            image != ''
                ? image
                : 'https://lanecdr.org/wp-content/uploads/2019/08/placeholder.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xFF101010).withOpacity(0.9)),
          Padding(
            padding: EdgeInsets.only(
                left: 20, right: 20, top: AppBar().preferredSize.height + 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    getIcon(categories[0]),
                    color: TextColorLight,
                    size: 72,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: RegexTextHighlight(
                    highlightRegex: numberRegex,
                    text: title,
                    nonHighlightStyle: h3.copyWith(color: TextColorLight3),
                    // semiHighlightStyle: h3.copyWith(color: TextColorLight2),
                    highlightStyle: h3.copyWith(color: TextColorLight),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 40),
                  child: Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: body.copyWith(color: TextColorLight),
                  ),
                ),
                Text(
                  'Swipe left to read more...',
                  style: body.copyWith(
                      color: TextColorLight, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: 10.0,
                      children: getCategories(categories),
                    ),
                    FloatingActionButton.large(
                        onPressed: () {
                          action();
                        },
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: Icon(FeatherIcons.share2)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToDashboard() {
    _nagivationService.navigateTo(Routes.dashboardView);
  }
}
