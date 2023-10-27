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

class testAdd extends StatefulWidget {
  const testAdd({super.key});

  @override
  State<testAdd> createState() => _testAddState();
}

class _testAddState extends State<testAdd> {
  late Future<List<Boxin>> FutureBoxin;
  List<Boxin> items = []; // Lista de Boxin

  @override
  void initState() {
    super.initState();
    FutureBoxin = listBox();
  }

  // Função para adicionar um novo BoxOpen
  void addNewBoxOpen() async {
    String title = await _requestTitle(context);
    final newBoxOpen = Boxin(
      box: '',
      title: title,
      image: 'caminho_da_imagem',
      route: 'nova_rota',
    );
    setState(() {
      items.add(newBoxOpen);
    });
  }

  Future<String> _requestTitle(BuildContext context) async {
    String? title;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edite as configurações do novo Box:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(onChanged: (value) {
                title = value;
              }),
              TextField(onChanged: (value) => )
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return title ?? '';
  }

/* 
  // Função para editar um BoxOpen

*/

  Future<void> _editBoxOpen(Boxin boxin) async {
    final updatedBoxin = await showDialog<Boxin>(
      context: context,
      builder: (context) {
        TextEditingController titleController = TextEditingController(text: boxin.title);
        TextEditingController imageController = TextEditingController(text: boxin.image);
        TextEditingController routeController = TextEditingController(text: boxin.route);

        return AlertDialog(
          title: const Text('Editar BoxOpen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: 'URL da Imagem'),
              ),
              TextField(
                controller: routeController,
                decoration: const InputDecoration(labelText: 'Rota'),
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
              child: const Text('Salvar'),
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
  // fim do modificador de BoxOpen

  String allBoxOpenData = "";

  void _generateAllBoxOpenData() {
    final List<Map<String, dynamic>> allData = [];

    for (final boxin in items) {
      allData.add(boxin.toJson());
    }

    final jsonData = jsonEncode(allData);
    setState(() {
      allBoxOpenData = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic(context),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                width: 900,
                child: FutureBuilder(
                  future: FutureBoxin,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      items = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
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
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => _editBoxOpen(items[i]),
                                    ),
                                  ],
                                ),
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
            Container(
              margin: const EdgeInsets.all(100),
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: _generateAllBoxOpenData, // Chama a função para gerar o JSON
                child: const Text('Enviar'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 100, left: 100, bottom: 100),
              height: 50,
              child: ElevatedButton(
                  onPressed: () => print(allBoxOpenData),
                  child: const Text('ver dados no console')),
            ),
            Text(allBoxOpenData),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBoxOpen,
        child: const Icon(Icons.add),
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
    data['box'] = box;
    data['title'] = title;
    data['image'] = image;
    data['route'] = route;
    return data;
  }
}
