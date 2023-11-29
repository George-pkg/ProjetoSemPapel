// libs
import 'dart:convert';
import 'package:http/http.dart' as http;
// models/utils
import 'package:sem_papel/models/file_json.dart';

Future<FileJson> fileList(idFile) async {
  try {
    final response = await http.get(Uri.parse('https://api.projetosempapel.com/files/$idFile'));

    if (response.statusCode == 200) {
      return FileJson.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('erro ao conectar ao servidor');
    }
  } catch (e) {
    throw Exception('Error com conexão: $e');
  }
}
