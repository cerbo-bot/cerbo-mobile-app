import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_bot/constants/styles.dart';

class BotHomeWidget extends StatelessWidget {
  final VoidCallback executeOperation;
  BotHomeWidget({required this.executeOperation});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 20),
          child: Center(
              child: Image.asset(
            "images/bot.png",
            width: 144,
          )),
        ),
        Text(
          "Hi!\nI'm Cerbo.",
          style: h2,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Let's learn something new...",
            style: h4,
            textAlign: TextAlign.center,
          ),
        ),
        TextButton(
            onPressed: executeOperation,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "What's new",
                style: h4.copyWith(color: PrimaryColor),
              ),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(SecondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200.0),
                        side: BorderSide(color: PrimaryColor)))))
      ],
    );
  }
}
