import 'package:cerbo/models/news_list.dart';

class Category {
  NewsList? carousel;
  Map<String, NewsList>? regionalNews;

  Category({this.carousel, this.regionalNews});

  Category.fromJson(Map<String, dynamic> json) {
    if (json['carousel'] != null) {
      carousel = new NewsList.fromJson(json["carousel"]);
    }
    if (json["regional news"] != null) {
      regionalNews = {};
      (json["regional news"]).forEach((key, value) {
        regionalNews?[key] = new NewsList.fromJson(value);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carousel != null) {
      data['carousel'] = this.carousel?.toJson();
    }
    if (this.regionalNews != null) {
      this.regionalNews?.forEach((k, v) {
        data['regional news'] = {k: v.toJson()};
      });
    }
    return data;
  }
}
