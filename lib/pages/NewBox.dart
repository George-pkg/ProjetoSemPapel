// ignore_for_file: avoid_print, deprecated_member_use, non_constant_identifier_names, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/components/decoration_input.dart';

import 'package:my_app/widgets/appBarDynamic.dart';
import 'package:my_app/utils/colors.dart';

Future<CreateBoxList> CreateBox(String title) async {
  try {
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
  } catch (e) {
    print('Erro ao criar a caixa: $e');
    throw Exception('Erro ao criar a caixa');
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
  final _validationKey = GlobalKey<FormState>();

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
            child: Form(
              key: _validationKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/psp-logo.svg',
                    color: ColorsPage.gray,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "O nome não pode ser nulo";
                        } else if (value.length < 3) {
                          return "O título precisa ter no mínimo 3 caracteres";
                        }

                        return null;
                      },
                      controller: nameBox,
                      keyboardType: TextInputType.text,
                      decoration: DecorationInput("Cria nova caixa", ColorsPage.greenDark)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          _futureCreateBoxList = CreateBox(nameBox.text);
                        });
                        final createBox = await _futureCreateBoxList;

                        ValidationBox(createBox!.id);
                      } catch (e) {
                        // Handle error, show a snackbar or display an error message
                        print('Error creating box: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Erro ao criar a caixa. Por favor, tente novamente.'),
                          ),
                        );
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
      ),
    );
  }

  ValidationBox(String id) {
    if (_validationKey.currentState!.validate()) {
      context.push('/Boxes/$id');
    }
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
