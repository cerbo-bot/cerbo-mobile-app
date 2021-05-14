import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:my_bot/constants/styles.dart';

class AnimatedSyncButton extends StatefulWidget {
  final Function() onPressedButton;
  final Function(AnimationSyncButtonController) animationCallback;
  AnimatedSyncButton(
      {required this.onPressedButton, required this.animationCallback});
  @override
  _AnimatedSyncButtonState createState() => _AnimatedSyncButtonState();
}

class _AnimatedSyncButtonState extends State<AnimatedSyncButton>
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
        _angleOfRotation = controller.value.toInt();
      });
    });

    AnimationSyncButtonController animationSyncButtonController =
        AnimationSyncButtonController(startAnimation, stopAnimation);

    // lifting the controllers for the widget to host activity
    widget.animationCallback(animationSyncButtonController);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: _angleOfRotation * math.pi / 360,
        child: IconButton(
          icon: Icon(
            Icons.cached_rounded,
            color: TextColorDark,
          ),
          onPressed: () {
            setState(() {
              startAnimation(widget.onPressedButton);
            });
          },
        ));
  }

  bool stopAnimation() {
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

  bool startAnimation(Function onPressed) {
    if (!_isAnimating) {
      _isAnimating = true;
      onPressed();
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
  Function startAnimation;
  Function stopAnimation;
  AnimationSyncButtonController(this.startAnimation, this.stopAnimation);
}
