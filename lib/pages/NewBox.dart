import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:my_app/widgets/appBarDynamic.dart';
import 'package:my_app/utils/colors.dart';

Future<CreateBoxList> CreateBox(String title) async {
  final response = await http.post(
    Uri.parse('https://api.projetosempapel.com/Boxes'),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode(
      <String, String>{
        "title": title,
      },
    ),
  );

  if (response.statusCode == 200) {
    return CreateBoxList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Erro ao se conectar ao Servidor');
  }
}

class NewBox extends StatefulWidget {
  const NewBox({super.key});

  @override
  State<NewBox> createState() => _NewBoxState();
}

class _NewBoxState extends State<NewBox> {
  Future<CreateBoxList>? _futureCreateBoxList;
  TextEditingController nameBox = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDaynamic(context),
      backgroundColor: ColorsPage.whiteSmoke,
      body: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/psp-logo.svg',
                  color: ColorsPage.gray,
                ),
                TextField(
                  controller: nameBox,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Criar uma caixa",
                    labelStyle: TextStyle(color: ColorsPage.greenDark),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: ColorsPage.green),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: ColorsPage.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _futureCreateBoxList = CreateBox(nameBox.text);
                    });
                    final createBox = await _futureCreateBoxList;

                    if (createBox != null) {
                      _redirectToBoxPage(createBox.id);
                    } else {
                      print('Erro na criação da caixa');
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(ColorsPage.green),
                      fixedSize: MaterialStatePropertyAll(Size(400, 50))),
                  child: const Text('Criar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<CreateBoxList> buildFutureBuilder() {
    String error = 'error';
    return FutureBuilder<CreateBoxList>(
      future: _futureCreateBoxList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.id);
        } else if (snapshot.hasError) {
          return Text(error);
        }

        return const CircularProgressIndicator();
      },
    );
  }

  void _redirectToBoxPage(String id) {
    // Redirecione a rota aqui
    context.go('/Boxes/$id');
  }
}

class CreateBoxList {
  final String title;
  final String id;

  const CreateBoxList({required this.title, required this.id});

  factory CreateBoxList.fromJson(Map<String, dynamic> json) {
    return CreateBoxList(
      title: json['title'],
      id: json['id'],
    );
  }
}
