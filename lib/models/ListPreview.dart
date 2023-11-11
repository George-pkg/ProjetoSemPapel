// ignore_for_file: file_names

class ListPreview {
  int? id;
  String? title;
  String? subtitle;
  String? image;

  ListPreview({this.id, this.title, this.subtitle, this.image});

  ListPreview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['image'] = image;
    return data;
  }
}
