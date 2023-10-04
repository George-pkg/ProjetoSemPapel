import 'package:flutter/material.dart';
import 'package:my_app/widgets/login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> SortPhrase() async {
    var url = Uri.parse('https://api.adviceslip.com/advice');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao se conectar ao Servidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: Center(
          child: Container(
              width: 450,
              height: 500,
              decoration: const BoxDecoration(
                  color: Colors.deepPurple, borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const Login()));
                    },
                    child: Text('voltar'),
                  ),
                ],
              )),
        ));
  }
}
