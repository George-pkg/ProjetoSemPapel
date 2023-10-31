import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/appBarDynamic.dart';

Future<List<ListPreview>> listView(id) async {
  final response = await http.get(Uri.parse('http://localhost:5000/json/$id.json'));

  if (response.statusCode == 200) {
    List listV = json.decode(response.body);
    return listV.map((json) => ListPreview.fromJson(json)).toList();
  } else {
    throw Exception('Erro ao se conectar ao Servidor');
  }
}

class ListPreview {
  int? id;
  String? title;
  String? subtitle;
  String? image;

  ListPreview({this.id, this.title, this.subtitle, this.image});

  ListPreview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['image'] = image;
    return data;
  }
}

class IDView extends StatefulWidget {
  final dynamic id;

  const IDView({Key? key, required this.id}) : super(key: key);

  @override
  State<IDView> createState() => _IDViewState();
}

class _IDViewState extends State<IDView> {
  late Future<List<ListPreview>> futureListPreview;

  @override
  void initState() {
    super.initState();
    futureListPreview = listView(widget.id);
  }

  /* 
  // Função para editar a lista

  */
  List<ListPreview> items = [];

  Future<void> _editListPreview(ListPreview list) async {
    await showDialog<ListPreview>(
      context: context,
      builder: (context) {
        TextEditingController titleController = TextEditingController(text: list.title);
        TextEditingController subtitleController = TextEditingController(text: list.subtitle);

        return AlertDialog(
          title: const Text('Editar Elemento: '),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'title'),
            ),
            TextField(
              controller: subtitleController,
              decoration: const InputDecoration(labelText: 'Subtitle'),
            )
          ]),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && subtitleController.text.isNotEmpty) {
                  setState(() {
                    list.title = titleController.text;
                    list.subtitle = subtitleController.text;
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            )
          ],
        );
      },
    );
  }
  // fim do modificador de BoxOpen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic(context),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: FutureBuilder(
        future: futureListPreview,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ListPreview listPreview = snapshot.data![index];
                  return ListTile(
                    contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    leading: Image(image: NetworkImage(listPreview.image!), height: 40),
                    title: Text(listPreview.title!),
                    trailing: IconButton(
                      onPressed: () {
                        _editListPreview(listPreview);
                        print(snapshot.data![index].id);
                      },
                      icon: const Icon(Icons.edit, color: Colors.black54),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
