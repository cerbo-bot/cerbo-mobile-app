import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatedWidget extends StatefulWidget {
  final Function(AnimationSyncButtonController) animationCallback;
  final Widget widgetToAnimate;
  RotatedWidget(
      {required this.animationCallback, required this.widgetToAnimate});
  @override
  _RotatedWidgetState createState() => _RotatedWidgetState();
}

class _RotatedWidgetState extends State<RotatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  int _angleOfRotation = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 360,
    );

    controller.addListener(() {
      setState(() {
        _angleOfRotation = 360 - controller.value.toInt();
      });
    });

    AnimationSyncButtonController animationSyncButtonController =
        AnimationSyncButtonController(rotate, stop);

    // lifting the controllers for the widget to host activity
    widget.animationCallback(animationSyncButtonController);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angleOfRotation * math.pi / 360,
      child: widget.widgetToAnimate,
    );
  }

  bool stop() {
    if (_isAnimating) {
      _isAnimating = false;
      setState(() {
        controller.stop();
        _isAnimating = false;
        _angleOfRotation = 0;
      });
      return true;
    }
    return false;
  }

  bool rotate() {
    if (!_isAnimating) {
      _isAnimating = true;
      setState(() {
        controller.repeat(reverse: false);
      });
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimationSyncButtonController {
  Function rotate;
  Function stop;
  AnimationSyncButtonController(this.rotate, this.stop);
}
