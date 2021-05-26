import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/constants/url_helper.dart';
import 'package:cerbo/models/advice.dart';

class APIService {
  final log = getLogger('APIService');

  Future<Response> getStory(String storyUrl) async {
    return await http.get(Uri.parse(storyUrl));
  }

  Future<List<dynamic>> getTopStories(token) async {
    var url = Uri.parse((UrlHelper.urlForTopStories()));
    log.d(url.toString());
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    log.d(response.statusCode);
    if (response.statusCode == 200) {
      List storyUrls = jsonDecode(response.body)["message"];
      return storyUrls;
    } else {
      log.e(response.statusCode);
      throw Exception("Unable to fetch data!");
    }
  }
}
