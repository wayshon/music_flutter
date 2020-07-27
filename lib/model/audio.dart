class AudioModel {
  final String id;
  final String name;
  final String author;
  final String url;
  final String cover;
  final String background;

  AudioModel(
      this.id, this.name, this.author, this.url, this.cover, this.background);

  AudioModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        author = json['author'],
        url = json['url'],
        cover = json['cover'],
        background = json['background'];

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["author"] = this.author;
    map["url"] = this.url;
    map["cover"] = this.cover;
    map["background"] = this.background;
    return map;
  }
}
