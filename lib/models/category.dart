class Category {
  String? name;
  String? image;

  Category({this.image, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["image"] = this.image;
    return data;
  }
}
