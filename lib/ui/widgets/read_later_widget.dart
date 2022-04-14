import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/models/news.dart';
import 'package:flutter/cupertino.dart';

class ReadLaterWidget extends StatefulWidget {
  final void Function(News) addToReadLater;
  final void Function(News) removeNewsFromHistory;
  final News? news;
  final bool shouldShowReadLater;
  const ReadLaterWidget(
      {Key? key,
      required this.addToReadLater,
      required this.news,
      required this.shouldShowReadLater,
      required this.removeNewsFromHistory})
      : super(key: key);

  @override
  _ReadLaterWidgetState createState() => _ReadLaterWidgetState();
}

class _ReadLaterWidgetState extends State<ReadLaterWidget> {
  bool didAddToReadLater = false;
  bool isAddedToReadLater = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.shouldShowReadLater
            ? isAddedToReadLater
                ? Icon(
                    CupertinoIcons.check_mark,
                    size: 16,
                    color: TextColorUnSelected,
                  )
                : Icon(
                    CupertinoIcons.eyeglasses,
                    size: 16,
                    color: TextColorUnSelected,
                  )
            : Icon(
                CupertinoIcons.delete,
                size: 16,
                color: TextColorUnSelected,
              ),
        SizedBox(width: 8),
        widget.shouldShowReadLater
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isAddedToReadLater = true;
                  });
                  if (widget.news != null) {
                    widget.addToReadLater(widget.news!);
                  }
                },
                child: Text(
                  "Read later",
                  style: captionLight,
                ),
              )
            : GestureDetector(
                onTap: () {
                  if (widget.news != null) {
                    widget.removeNewsFromHistory(widget.news!);
                  }
                },
                child: Text(
                  "Remove",
                  style: captionLight,
                ),
              ),
      ],
    );
  }
}
