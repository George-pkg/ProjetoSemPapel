class homeP {
  Box? box;

  homeP({this.box});

  homeP.fromJson(Map<String, dynamic> json) {
    box = json['box'] != null ? Box.fromJson(json['box']) : null;
  }

  get length => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.box != null) {
      data['box'] = this.box!.toJson();
    }
    return data;
  }
}

class Box {
  int? boxin;
  String? title;
  String? image;

  Box({this.boxin, this.title, this.image});

  Box.fromJson(Map<String, dynamic> json) {
    boxin = json['boxin'];
    title = json['Title'];
    image = json['image'];
  }

  get length => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['boxin'] = this.boxin;
    data['Title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}