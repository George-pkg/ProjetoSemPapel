import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:my_app/models/ListPreview.dart';
import 'package:my_app/testes/old/appBarDynamica.dart';

Future<List<ListPreview>> listView(id) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:5000/json/$id.json'));

  if (response.statusCode == 200) {
    List listV = json.decode(response.body);
    return listV.map((json) => ListPreview.fromJson(json)).toList();
  } else {
    throw Exception('Erro ao se conectar ao Servidor');
  }
}

class FolderPreview extends StatefulWidget {
  final dynamic id;

  const FolderPreview({Key? key, required this.id}) : super(key: key);

  @override
  State<FolderPreview> createState() => _FolderPreviewState();
}

class _FolderPreviewState extends State<FolderPreview> {
  late Future<List<ListPreview>> futureListPreview;
  List<ListPreview> items = [];

  @override
  void initState() {
    super.initState();
    futureListPreview = listView(widget.id);
  }

  /* 
    __Future for Edit ListPreview__

  */
  Future<void> _editListPreview(ListPreview list) async {
    await showDialog<ListPreview>(
      context: context,
      builder: (context) {
        print(items);
        // get elements from ListPreview
        TextEditingController titleController = TextEditingController(text: list.title);
        TextEditingController subtitleController = TextEditingController(text: list.subtitle);

        return AlertDialog(
          // object in alert box
          title: const Text('Editar Elemento: '),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            // inputs
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
                } else {
                  // limpa qualquer mensagem que estiver na tela
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  // notifica uma mensagem nova notificando algum erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha todos os dados para alteração!',
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                      backgroundColor: Color.fromARGB(200, 194, 28, 16),
                    ),
                  );
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
  /* */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamica(context),
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
