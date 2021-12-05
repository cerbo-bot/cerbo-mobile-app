class News {
  String? title;
  String? description;
  String? img;
  String? author;
  String? category;
  int? readTime;
  int? createdAt;
  String? link;
  int? views;

  News(
      {this.title,
      this.description,
      this.img,
      this.author,
      this.category,
      this.readTime,
      this.createdAt,
      this.link,
      this.views});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    img = json['img'];
    author = json['author'];
    category = json['category'];
    readTime = json['read_time'];
    createdAt = json['created_at'];
    link = json['link'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['img'] = this.img;
    data['author'] = this.author;
    data['category'] = this.category;
    data['read_time'] = this.readTime;
    data['created_at'] = this.createdAt;
    data['link'] = this.link;
    data['views'] = this.views;
    return data;
  }
}
