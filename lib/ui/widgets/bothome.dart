import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/services/string_helper.dart';

class BotHomeWidget extends StatelessWidget {
  final VoidCallback executeOperation;
  final String userName;
  BotHomeWidget({required this.executeOperation, this.userName = ""});
  Widget _getBotImage() {
    return Image.asset('images/cerbo.png');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Center(child: Container(height: 200, child: _getBotImage())),
        ),
        Text(
          "Hi ${userName.split(' ')[0].capitalize()}\nI'm Cerbo.",
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
