class Boxin {
  String? box;
  String? title;
  String? image;
  String? route;

  Boxin({this.box, this.title, this.image, this.route});

  Boxin.fromJson(Map<String, dynamic> json) {
    box = json['box'];
    title = json['title'];
    image = json['image'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['box'] = this.box;
    data['title'] = this.title;
    data['image'] = this.image;
    data['route'] = this.route;
    return data;
  }
}
