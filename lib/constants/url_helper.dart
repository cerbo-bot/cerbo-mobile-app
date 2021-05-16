import 'package:flutter_config/flutter_config.dart';

class UrlHelper {
  static String BASE_URL = FlutterConfig.get('BASE_URL_DEVELOPMENT');
  static String urlForTopStories() {
    return '$BASE_URL/news';
  }

  static String urlForCommentById(int commentId) {
    return "https://hacker-news.firebaseio.com/v0/item/${commentId}.json?print=pretty";
  }
}
