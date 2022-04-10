import 'package:cerbo/models/author.dart';

class News {
  Author? author;
  String? title;
  String? text;
  String? image;
  String? content;
  List<String?>? categories;
  String? url;
  String? id;
  String? date;
  String? link;

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
    categories = json['categories'];
    id = json['_id'];
    url = json["url"];
    date = json['date'];
    link = json["link"];
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
    data["link"] = this.link;
    return data;
  }
}
