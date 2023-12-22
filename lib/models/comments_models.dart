class Comments {
  int? id;
  late String photoUrl;
  late String name;
  late String title;
  late String description;
  String? hour;
  bool? modified;

  Comments({
    this.id,
    required this.photoUrl,
    required this.name,
    required this.title,
    required this.description,
    this.hour,
    this.modified,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'name': name,
      'title': title,
      'description': description,
      'hour': hour,
      'modified': modified,
    };
  }

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      id: json['id'],
      photoUrl: json['photoUrl'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
      hour: json['hour'],
      modified: json['modified'],
    );
  }
}
