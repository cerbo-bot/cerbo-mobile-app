import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:my_bot/app/app.logger.dart';
import 'package:my_bot/constants/url_helper.dart';
import 'package:my_bot/models/advice.dart';

class APIService {
  final log = getLogger('APIService');

  Future randomAdvice(String token) async {
    Map msg = {'message': 'hi'};
    String body = jsonEncode(msg);
    var response =
        await http.post(Uri.parse('https://event-hub-efa45xwu7a-uc.a.run.app'),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $token',
            },
            body: body);
    return;
  }

  Future<Response> getStory(String storyUrl) async {
    return await http.get(Uri.parse(storyUrl));
  }

  Future<List<dynamic>> getTopStories() async {
    final response = await http.get(Uri.parse((UrlHelper.urlForTopStories())));
    if (response.statusCode == 200) {
      List storyUrls = jsonDecode(response.body)["message"];
      return storyUrls;
    } else {
      throw Exception("Unable to fetch data!");
    }
  }
}
