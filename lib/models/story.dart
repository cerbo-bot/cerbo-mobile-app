class Story {
  final String title;
  final String url;
  final String by;

  Story({this.title = "", this.url = "", this.by = ""});

  factory Story.fromJSON(Map<String, dynamic> json) {
    return Story(
      title: json["title"] ?? "",
      url: json["url"] ?? "",
      by: json["by"] ?? "",
    );
  }
}
