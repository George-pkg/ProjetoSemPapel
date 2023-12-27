class Comments {
  int? id;
  late String photoUrl;
  late String name;
  late String title;
  late String description;
  String? time;
  bool modified;

  Comments({
    this.id,
    required this.photoUrl,
    required this.name,
    required this.title,
    required this.description,
    this.time,
    this.modified = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'name': name,
      'title': title,
      'description': description,
      'time': time,
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
      time: json['time'],
      modified: json['modified'],
    );
  }
}
