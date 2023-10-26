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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['image'] = this.image;
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
                    leading: Image(image: NetworkImage(listPreview.image!), height: 40),
                    title: Text(listPreview.title!),
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
