import 'news.dart';

class NewsList {
  List<News>? newsList;
  NewsList({this.newsList});

  NewsList.fromJson(List<dynamic>? jsonList) {
    if (jsonList != null && jsonList.isNotEmpty) {
      newsList = [];
      jsonList.forEach((v) {
        newsList?.add(new News.fromJson(v));
      });
    }
  }

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> data = [];
    if (this.newsList != null) {
      data.addAll(this.newsList?.map((v) => v.toJson()).toList() ?? []);
    }
    return data;
  }
}
