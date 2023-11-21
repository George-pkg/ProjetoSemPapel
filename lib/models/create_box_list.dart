class CreateBoxList {
  final String title;
  final String id;

  const CreateBoxList({required this.title, required this.id});

  factory CreateBoxList.fromJson(Map<String, dynamic> json) {
    return CreateBoxList(
      title: json['title'],
      id: json['id'],
    );
  }
}