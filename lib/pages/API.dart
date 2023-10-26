import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:my_app/models/appBarDynamic.dart';

Future<SortPhrase> phrase() async {
  final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));

  if (response.statusCode == 200) {
    return SortPhrase.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Erro ao se conectar ao Servidor');
  }
}

class SortPhrase {
  final String name;
  final String phrase;

  SortPhrase({
    required this.name,
    required this.phrase,
  });

  factory SortPhrase.fromJson(Map<String, dynamic> json) {
    return SortPhrase(
      name: json['id'],
      phrase: json['value'],
    );
  }
}

class API extends StatefulWidget {
  const API({super.key});

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  late Future<SortPhrase> futureSortPhrase;

  @override
  void initState() {
    super.initState();
    futureSortPhrase = phrase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDynamic(context),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: Center(
          child: Container(
              width: 450,
              height: 500,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 203, 208, 228),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        context.go('/HomePage');
                      },
                      child: const Text('voltar'),
                    ),
                    const SizedBox(height: 180),
                    const Text('Chuck Norris quotes:', style: TextStyle(fontSize: 22)),
                    const SizedBox(height: 30),
                    FutureBuilder(
                      future: futureSortPhrase,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.phrase,
                            style: const TextStyle(fontSize: 18),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return const CircularProgressIndicator();
                      },
                    )
                  ],
                ),
              )),
        ));
  }
}
