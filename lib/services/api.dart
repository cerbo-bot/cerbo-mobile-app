import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/constants/url_helper.dart';

class APIService {
  final log = getLogger('APIService');

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
