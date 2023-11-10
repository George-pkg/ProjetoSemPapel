import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:my_app/testes/old/BoxOpen.dart';
import 'package:my_app/testes/old/appBarDynamica.dart';

Future<List<Boxin>> listBox() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:5000/json/twoBox.json'));

  if (response.statusCode == 200) {
    List list = jsonDecode(response.body);
    return list.map((json) => Boxin.fromJson(json)).toList();
  } else {
    throw Exception('Erro ao se conectar ao Servidor');
  }
}

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  late Future<List<Boxin>> FutureBoxin;

  @override
  void initState() {
    super.initState();
    FutureBoxin = listBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDynamica(context),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: Center(
            child: Container(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                width: 900,
                child: FutureBuilder(
                    future: FutureBoxin,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final box = snapshot.data!;
                        return ListView.builder(
                          itemCount: (box.length / 2).ceil(),
                          itemBuilder: (context, index) {
                            final startIndex = index * 2;
                            final endIndex = min(startIndex + 2, box.length);

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (var i = startIndex; i < endIndex; i++)
                                  BoxOpen(box[i].title!, box[i].image!, box[i].route!),
                              ],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }

                      return Center(
                        child: Container(
                          width: 90,
                          height: 90,
                          child: const CircularProgressIndicator(
                            color: Colors.deepPurple,
                          ),
                        ),
                      );
                    }))));
  }
}

class Boxin {
  String? box;
  String? title;
  String? image;
  String? route;

  Boxin({this.box, this.title, this.image, this.route});

  Boxin.fromJson(Map<String, dynamic> json) {
    box = json['box'];
    title = json['title'];
    image = json['image'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['box'] = box;
    data['title'] = title;
    data['image'] = image;
    data['route'] = route;
    return data;
  }
}
