import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:my_app/models/BoxOpen.dart';
import 'package:my_app/models/appBarDynamic.dart'; // Importe o módulo dart:math

Future<List<Boxin>> listBox() async {
  final response = await http.get(Uri.parse('http://localhost:5000/json/oneBox.json'));

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
  List<Boxin> items = []; // Lista de Boxin

  @override
  void initState() {
    super.initState();
    FutureBoxin = listBox();
  }

  // Função para adicionar um novo BoxOpen
  void addNewBoxOpen() {
    final newBoxOpen = Boxin(
      box: 'Nova Caixa',
      title: 'Novo Título',
      image: 'caminho_da_imagem',
      route: 'nova_rota',
    );
    setState(() {
      items.add(newBoxOpen);
    });
  }

  // Função para editar um BoxOpen
  Future<void> _editBoxOpen(Boxin boxin) async {
    final updatedBoxin = await showDialog<Boxin>(
      context: context,
      builder: (context) {
        TextEditingController titleController = TextEditingController(text: boxin.title);
        TextEditingController imageController = TextEditingController(text: boxin.image);
        TextEditingController routeController = TextEditingController(text: boxin.route);

        return AlertDialog(
          title: Text('Editar BoxOpen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
              TextField(
                controller: routeController,
                decoration: InputDecoration(labelText: 'Rota'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                final editedBoxin = Boxin(
                  box: boxin.box,
                  title: titleController.text,
                  image: imageController.text,
                  route: routeController.text,
                );
                Navigator.of(context).pop(editedBoxin);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (updatedBoxin != null) {
      setState(() {
        final index = items.indexWhere((item) => item == boxin);
        if (index >= 0) {
          items[index] = updatedBoxin;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic(context),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          width: 900,
          child: FutureBuilder(
            future: FutureBoxin,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                items = snapshot.data!;
                return ListView.builder(
                  itemCount: (items.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    final startIndex = index * 2;
                    final endIndex = min(startIndex + 2, items.length);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var i = startIndex; i < endIndex; i++)
                          Column(
                            children: [
                              BoxOpen(items[i].title!, items[i].image!, items[i].route!),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _editBoxOpen(items[i]),
                              ),
                            ],
                          ),
                        if (endIndex - startIndex == 1)
                          Container(width: MediaQuery.of(context).size.width / 4),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              return Container(
                width: 10,
                height: 30,
                decoration: const BoxDecoration(color: Colors.deepPurple),
                child: const CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBoxOpen,
        child: Icon(Icons.add),
      ),
    );
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
    data['box'] = this.box;
    data['title'] = this.title;
    data['image'] = this.image;
    data['route'] = this.route;
    return data;
  }
}
