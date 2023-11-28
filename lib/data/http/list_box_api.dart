// libs
import 'dart:convert';
import 'package:http/http.dart' as http;
// models/utils
import 'package:sem_papel/models/box_dice.dart';

Future<BoxDice> listBox(idPage) async {
  try {
    final response = await http.get(Uri.parse('https://api.projetosempapel.com/Boxes/$idPage'));

    if (response.statusCode == 200) {
      return BoxDice.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao se conectar ao Servidor');
    }
  } catch (e) {
    throw Exception('Problema com a internet');
  }
}
