import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/models/category.dart';
import 'package:flutter/material.dart';

class CerboCategoryCard extends StatelessWidget {
  const CerboCategoryCard({Key? key, this.category}) : super(key: key);
  final Category? category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Column(
        children: [
          Flexible(
              fit: FlexFit.loose,
              flex: 8,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    height: constraints.maxHeight,
                    width: constraints.maxHeight,
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TextColorUnSelected,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            category?.image ??
                                "https://cdn.pixabay.com/photo/2020/12/09/18/40/naruto-5818254_1280.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              )),
          Flexible(
            flex: 2,
            child: Text(
              category?.name ?? "",
              style: captionBold,
            ),
          )
        ],
      ),
    );
  }
}
