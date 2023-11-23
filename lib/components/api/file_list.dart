// libs
import 'dart:convert';
import 'package:http/http.dart' as http;
// models/utils
import 'package:sem_papel/models/file_json.dart';

Future<fileJson> fileList(idFile) async {
  final response = await http.get(Uri.parse('https://api.projetosempapel.com/files/$idFile'));

  if (response.statusCode == 200) {
    return fileJson.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('erro ao conectar ao servidor');
  }
}
