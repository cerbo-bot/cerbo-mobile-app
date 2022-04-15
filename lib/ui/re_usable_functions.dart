import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

String capitailze(String stringToCapitalize) {
  return "${stringToCapitalize[0].toUpperCase()}${stringToCapitalize.substring(1)}";
}

void showSnakBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<void> launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    );
  } else {
    throw 'Could not launch $url';
  }
}

void share(
    {String title = "shared via Cerbo",
    required String message,
    String subject = ""}) {
  Share.share(message + ":" + title, subject: subject);
}

String getTimeInString(int time) {
  String resultTime = "∞";
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int days = 0;
  if (time < 60) {
    return "$time min";
  }
  if (time > 60) {
    hours = (time ~/ 60);
    minutes = (time % 60);
    resultTime = "$hours hrs $minutes min";
  } else if (time > (24 * 60)) {
    days = time ~/ (24 * 60);
    hours = time % (24 * 60);
    resultTime = "$days d $hours hrs";
  }
  return resultTime;
}
