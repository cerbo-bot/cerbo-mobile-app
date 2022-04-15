import 'package:cerbo/models/author.dart';

class News {
  String? author;
  String? id;
  String? url;
  List<String?>? categories;
  String? content;
  String? date;
  String? image;
  String? src;
  String? text;
  String? title;

  News(
      {this.title,
      this.text,
      this.image,
      this.author,
      this.content,
      this.id,
      this.date,
      this.categories});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    image = json['image'];
    author = json['author'];
    content = json['content'];
    categories = List<String?>.from(json['categories']);
    id = json['_id'];
    url = json["url"];
    date = json['date'];
    src = json["src"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    data['image'] = this.image;
    data['author'] = this.author;
    data['content'] = this.content;
    data['categories'] = this.categories;
    data["url"] = this.url;
    data['created_at'] = this.id;
    data['date'] = this.date;
    data["src"] = this.src;
    return data;
  }
}
