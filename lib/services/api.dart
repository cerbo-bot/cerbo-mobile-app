import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:my_bot/app/app.logger.dart';
import 'package:my_bot/constants/url_helper.dart';
import 'package:my_bot/models/advice.dart';

class APIService {
  final log = getLogger('APIService');

  Future<Advice> randomAdvice() async {
    var response =
        await http.get(Uri.parse('https://api.adviceslip.com/advice'));
    if (response.statusCode == 200)
      return Advice.fromJson(jsonDecode(response.body));
    else
      return Advice(slip: Slip(slipId: 0, advice: "No Data."));
  }

  Future<Response> _getStory(String storyUrl) {
    return http.get(Uri.parse(storyUrl));
  }

  Future<List<Response>> getTopStories() async {
    final response = await http.get(Uri.parse((UrlHelper.urlForTopStories())));
    if (response.statusCode == 200) {
      Iterable storyUrls = jsonDecode(response.body)["message"];
      return Future.wait(storyUrls.take(20).map((storyUrl) {
        return _getStory(storyUrl);
      }));
    } else {
      throw Exception("Unable to fetch data!");
    }
  }
}
