import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:my_bot/app/app.logger.dart';
import 'package:my_bot/constants/url_helper.dart';
import 'package:my_bot/models/advice.dart';

class APIService {
  final log = getLogger('APIService');

  Future<Response> getStory(String storyUrl) async {
    return await http.get(Uri.parse(storyUrl));
  }

  Future<List<dynamic>> getTopStories() async {
    final response = await http.get(Uri.parse((UrlHelper.urlForTopStories())));
    log.d(response.statusCode);
    if (response.statusCode == 200) {
      List storyUrls = jsonDecode(response.body)["message"];
      return storyUrls;
    } else {
      throw Exception("Unable to fetch data!");
    }
  }
}
