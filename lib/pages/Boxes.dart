// ignore_for_file: file_names, deprecated_member_use
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:my_app/widgets/appBarDynamic.dart';
import 'package:my_app/utils/colors.dart';
import 'package:my_app/models/boxDice.dart';

Future<BoxDice> ListBox(idPage) async {
  final response = await http.get(Uri.parse('https://api.projetosempapel.com/Boxes/$idPage'));

  if (response.statusCode == 200) {
    return BoxDice.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Erro ao se conectar ao Servidor');
  }
}

class Boxes extends StatefulWidget {
  final dynamic id;

  const Boxes({Key? key, required this.id}) : super(key: key);

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  late Future<BoxDice> _futureBoxDice;

  @override
  void initState() {
    super.initState();
    _futureBoxDice = ListBox(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: appBarDaynamic(context),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SvgPicture.asset(
                      'assets/images/psp-logo.svg',
                      width: 300,
                      color: ColorsPage.gray,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                  FutureBuilder(
                    future: _futureBoxDice,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.title!,
                          style: const TextStyle(
                              fontFamily: "Goldplay-black",
                              fontSize: 25,
                              color: ColorsPage.blueDark),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }

                      return const CircularProgressIndicator();
                    },
                  ),
                  Image.asset('assets/images/quCode.png'),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: DottedBorder(
                      color: ColorsPage.greenDark,
                      strokeWidth: 1.1,
                      child: SizedBox(
                        height: 100,
                        width: 500,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Arraste arquivo(s) ou clique aqui para enviar',
                              style: TextStyle(color: Colors.black87)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
