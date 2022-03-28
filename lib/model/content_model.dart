List<ContentModel> productsFromJson(dynamic str) =>
    List<ContentModel>.from((str).map((x) => ContentModel.fromJson(x)));

class ContentModel {
  late String? id;
  late String? title;
  late String? content;

  ContentModel({
    this.id,
    this.title,
    this.content,
  });

  ContentModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['title'] = title;
    _data['content'] = content;

    return _data;
  }
}
