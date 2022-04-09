class News {
  List<NewsItem>? data;

  News({
    this.data,
  });

  News.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new List<NewsItem>.from(json['data'].map((x) => NewsItem.fromJson(x)))
        : json['message'] != null
            ? new List<NewsItem>.from(
                json['message'].map((x) => NewsItem.fromJson(x)))
            : null;
  }
}

class NewsItem {
  String? sId;
  List<String>? categories;
  String? content;
  String? date;
  String? id;
  String? image;
  String? source;
  String? text;
  String? title;
  String? url;

  NewsItem(
      {this.sId,
      this.categories,
      this.content,
      this.date,
      this.id,
      this.image,
      this.source,
      this.text,
      this.title,
      this.url});

  NewsItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categories = json['categories'].cast<String>();
    content = json['content'] != null ? json['content'] : '';
    date = json['date'];
    id = json['id'];
    image = json['image'];
    source = json['source'];
    text = json['text'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['categories'] = this.categories;
    data['content'] = this.content;
    data['date'] = this.date;
    data['id'] = this.id;
    data['image'] = this.image;
    data['source'] = this.source;
    data['text'] = this.text;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
