import 'package:cerbo/models/news.dart';
import 'package:flutter/widgets.dart';

class CerboCarouselCard extends StatelessWidget {
  final News? news;
  const CerboCarouselCard({Key? key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (news == null) return SizedBox();
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(
              news!.image ??
                  "https://www.pngitem.com/pimgs/m/108-1086648_naruto-png-transparent-png.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
