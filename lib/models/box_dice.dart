class BoxDice {
  List<Files>? files;
  String? sId;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? countFiles;
  String? id;

  BoxDice(
      {this.files,
      this.sId,
      this.title,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.countFiles,
      this.id});

  BoxDice.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    sId = json['_id'];
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    countFiles = json['countFiles'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['countFiles'] = countFiles;
    data['id'] = id;
    return data;
  }
}

class Files {
  String? sId;
  String? originalName;
  String? mimeType;
  int? size;
  String? url;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Files(
      {this.sId,
      this.originalName,
      this.mimeType,
      this.size,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Files.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    originalName = json['originalName'];
    mimeType = json['mimeType'];
    size = json['size'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['originalName'] = originalName;
    data['mimeType'] = mimeType;
    data['size'] = size;
    data['url'] = url;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
