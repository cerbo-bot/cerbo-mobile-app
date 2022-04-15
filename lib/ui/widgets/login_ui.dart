import 'package:cerbo/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginUI extends StatelessWidget {
  final void Function() loginFunction;
  final bool hideUI;
  LoginUI({required this.loginFunction, required this.hideUI});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: SecondaryColor,
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "cerbo v1.0",
                  style: subtitle1.copyWith(
                      color: TextColorDark, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                      child: Image.asset(
                    'images/login.png',
                    width: 400,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Hey there.",
                    style: subtitle1.copyWith(color: TextColorDark),
                  ),
                ),
                Text(
                  "Welcome to cerbo, a chat based search engine and news aggregator for techies. Login to explore more.",
                  style: caption.copyWith(color: TextColorDark),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: hideUI
                        ? Neumorphic(
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.concave,
                                boxShape: NeumorphicBoxShape.circle(),
                                color: SecondaryColor),
                            padding: EdgeInsets.all(18.0),
                            child: SpinKitDoubleBounce(
                              color: TextColorDark,
                              size: 50.0,
                            ),
                          )
                        : NeumorphicButton(
                            onPressed: loginFunction,
                            style: NeumorphicStyle(color: SecondaryColor),
                            child: Text(
                              "Login with Google",
                              style: heading6.copyWith(color: TextColorDark),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
