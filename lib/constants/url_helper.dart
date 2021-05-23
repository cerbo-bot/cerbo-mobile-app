import 'package:flutter_config/flutter_config.dart';

class UrlHelper {
  static String base_URL = _getBaseURL();

  static String urlForTopStories() {
    return '$base_URL/news';
  }

  static String urlForCommentById(int commentId) {
    return "https://hacker-news.firebaseio.com/v0/item/${commentId}.json?print=pretty";
  }

  static String _getBaseURL() {
    try {
      return FlutterConfig.get('BASE_URL_DEVELOPMENT');
    } catch (e) {
      return 'https://cerbo.platinos.in:4000/v1';
    }
  }
}
