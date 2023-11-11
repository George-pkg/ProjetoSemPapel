// ignore_for_file: camel_case_types, file_names

class fileJson {
  String? sId;
  String? originalName;
  String? mimeType;
  int? size;
  String? url;
  String? createdAt;
  String? updatedAt;
  int? iV;

  fileJson(
      {this.sId,
      this.originalName,
      this.mimeType,
      this.size,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.iV});

  fileJson.fromJson(Map<String, dynamic> json) {
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
