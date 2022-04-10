import 'dart:convert';

import 'package:cerbo/models/news.dart';
import 'package:cerbo/services/dummyData.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:http/http.dart' as http;
import 'package:cerbo/app/app.logger.dart';
import '../services/dummyData.dart';
import '../models/category.dart';

class APIService {
  final log = getLogger('APIService');

  Future<List<News>> getNews(token) async {
    var url = Uri.parse("https://cerbo.platinos.in/api/app/news/with-image");
    log.e("token $token");
    // var response =
    //     await http.get(url, headers: {"Authentication": "Bearer $token"});
    // Delegating work to a background isolate
    return compute(_parseNews, DummyData().provideNewsData());
  }

  Future<List<Category>> getCategories() async {
    var categoriesData = DummyData().provideCategoriesData();
    return compute(_parseCategories, categoriesData);
  }
}

List<Category> _parseCategories(List<Map<String, String>> responseBody) {
  // final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return responseBody.map<Category>((json) => Category.fromJson(json)).toList();
}

List<News> _parseNews(List<Map<String, dynamic>> responseBody) {
  // final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return responseBody.map<News>((json) => News.fromJson(json)).toList();
}
