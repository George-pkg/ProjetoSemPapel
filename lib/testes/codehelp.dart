import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

// ... Importe as dependências necessárias ...

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  late Future<List<Boxin>> FutureBoxin;
  List<Boxin> items = []; // Lista de Boxin
  String allBoxOpenData = ""; // Armazena o JSON com os dados de todos os BoxOpen

  @override
  void initState() {
    super.initState();
    FutureBoxin = listBox();
  }

  Future<String> _requestTitle(BuildContext context) async {
    String? title;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Digite o título do BoxOpen:'),
          content: TextField(
            onChanged: (value) {
              title = value;
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return title ?? '';
  }

  void _addNewBoxOpen() async {
    String title = await _requestTitle(context);
    // Solicite os outros campos (imagem, rota, etc.) da mesma maneira

    Boxin newBoxOpen = Boxin(
      box: 'Nova Caixa', // Defina o valor da caixa conforme necessário
      title: title,
      // Defina os outros campos do BoxOpen da mesma maneira
    );

    setState(() {
      items.add(newBoxOpen);
    });
  }

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
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          width: 900,
          child: FutureBuilder(
            future: FutureBoxin,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                items = snapshot.data; // Atualiza a lista de items
                return ListView.builder(
                  itemCount: (items.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    final startIndex = index * 2;
                    final endIndex = min(startIndex + 2, items.length);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var i = startIndex; i < endIndex; i++)
                          BoxOpen(items[i].title!, items[i].image!, items[i].route),
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _addNewBoxOpen, // Chama a função para adicionar um novo BoxOpen
            child: Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: _generateAllBoxOpenData, // Chama a função para gerar o JSON
            child: Text('Enviar JSON'),
          ),
          Text(allBoxOpenData), // Exibe o JSON gerado
        ],
      ),
    );
  }
}
