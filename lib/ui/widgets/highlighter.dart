import 'package:flutter/material.dart';

class RegexTextHighlight extends StatelessWidget {
  final String? text;
  final RegExp? highlightRegex;
  // final RegExp? semiHighlightRegex;
  final TextStyle? highlightStyle;
  final TextStyle? nonHighlightStyle;
  // final TextStyle? semiHighlightStyle;

  const RegexTextHighlight({
    @required this.text,
    @required this.highlightRegex,
    // @required this.semiHighlightRegex,
    @required this.highlightStyle,
    // @required this.semiHighlightStyle,
    this.nonHighlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = [];
    int start = 0;
    while (true) {
      final String? highlight =
          highlightRegex!.stringMatch(text!.substring(start));
      // final String? semiHighlight =
      //     semiHighlightRegex!.stringMatch(text!.substring(start));
      if (highlight == null) {
        // no highlight
        spans.add(_normalSpan(text!.substring(start)));
        break;
      }

      final int indexOfHighlight = text!.indexOf(highlight, start);
      // final int indexOfSemiHighlight = text!.indexOf(semiHighlight, start);

      if (indexOfHighlight == start) {
        // starts with highlight
        spans.add(_highlightSpan(highlight));
        start += highlight.length;
      } else {
        // normal + highlight
        spans.add(_normalSpan(text!.substring(start, indexOfHighlight)));
        spans.add(_highlightSpan(highlight));
        start = indexOfHighlight + highlight.length;
      }
    }

    return RichText(
      text: TextSpan(
        style: nonHighlightStyle ?? DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: highlightStyle);
  }

  // Text _semiHighlightSpan(String content) {
  //   return Text(content, style: semiHighlightStyle);
  // }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content);
  }
}
