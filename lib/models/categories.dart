import 'package:cerbo/models/category.dart';

class Categories {
  Category? popular;
  Category? recent;
  Category? trending;

  Categories.fromJson(Map<String, dynamic> json) {
    if (json["popular"] != null) {
      this.popular = Category.fromJson(json["popular"]);
    }
    if (json["recent"] != null) {
      this.recent = Category.fromJson(json["recent"]);
    }
    if (json["trending"] != null) {
      this.trending = Category.fromJson(json["trending"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.popular != null) {
      data["popular"] = popular?.toJson();
    }
    if (this.recent != null) {
      data["recent"] = recent?.toJson();
    }
    if (this.trending != null) {
      data["trending"] = trending?.toJson();
    }
    return data;
  }
}
