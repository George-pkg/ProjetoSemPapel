// libs
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadFile {
  // * constructor
  UploadFile() : _dio = Dio();

  // * dio
  late Response response;
  late final Dio _dio;

  // * rest api

  upload(List<int> bytes, String name, dynamic id, String extension) async {
    final String file;

    if (extension == "jpeg" || extension == "png" || extension == "jpg" || extension == "webp") {
      file = "image";
    } else if (extension == "mp4" || extension == "mov" || extension == "wmv") {
      file = "video";
    } else if (extension == "pdf") {
      file = "document";
    } else {
      file = "application";
    }

    var formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        bytes,
        filename: name,
        contentType: MediaType(file, extension),
      ),
    });

    response = await _dio.post("https://api.projetosempapel.com/Boxes/$id/files", data: formData);
  }
}
