import 'dart:convert';

import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/constants/url_helper.dart';
import 'package:cerbo/models/news_item.dart';
// import 'package:cerbo/models/news.dart';
import 'package:cerbo/models/category.dart';
import 'package:cerbo/services/dummyData.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:http/http.dart' as http;

class APIService {
  final log = getLogger('APIService');

  // Future<List<News>> getNews(token) async {
  //   // log.e(token);
  //   var url = Uri.parse("https://cerbo.platinos.in/api/app/news/with-image");
  //   var response =
  //       await http.get(url, headers: {"Authorization": "Bearer $token"});
  //   // Delegating work to a background isolate
  //   return compute(_parseNews, response.body);
  //   // return compute(_parseNews, DummyData().provideNewsData());
  // }

  // getNews
  Future<News> getNews(token) async {
    var url = Uri.parse((UrlHelper.base_URL + '/news/with-image'));
    log.d(url.toString());
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    log.d(response.statusCode);
    if (response.statusCode == 200) {
      News news = News.fromJson(jsonDecode(response.body));
      log.d(news.data!.length.toString() + " stories fetched");
      return news;
    } else {
      log.e(response.statusCode);
      throw Exception("Unable to fetch data!");
    }
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

List<News> _parseNews(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return parsed["data"].map<News>((json) => News.fromJson(json)).toList();
}
