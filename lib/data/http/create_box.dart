// libs
import 'dart:convert';
import 'package:http/http.dart' as http;
// models/utils
import 'package:sem_papel/models/create_box_list.dart';

Future<CreateBoxList> createBoxes(String title) async {
  try {
    final response = await http.post(
      Uri.parse('https://api.projetosempapel.com/Boxes'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, String>{
          "title": title,
        },
      ),
    );

    if (response.statusCode == 200) {
      return CreateBoxList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao se conectar ao Servidor');
    }
  } catch (e) {
    throw Exception('Erro ao criar a caixa');
  }
}
