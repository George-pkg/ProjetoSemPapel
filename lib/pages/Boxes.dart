// ignore_for_file: file_names, deprecated_member_use, avoid_print, non_constant_identifier_names
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:my_app/components/show_snackbar.dart';

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
    return Scaffold(
      appBar: appBarDaynamic(context),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: FutureBuilder(
              future: _futureBoxDice,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (!snapshot.hasData) {
                  return const Text('No data available');
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: SvgPicture.asset(
                          'assets/images/psp-logo.svg',
                          width: 250,
                          color: ColorsPage.gray,
                        ),
                      ),
                      Text(
                        snapshot.data!.title!,
                        style: const TextStyle(
                          fontFamily: "Goldplay-black",
                          fontSize: 25,
                          color: ColorsPage.blueDark,
                        ),
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
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  try {
                                    PlatformFile file = result.files.first;

                                    final String mimeType;

                                    if (file.extension == "png" || file.extension == "jpeg") {
                                      mimeType = "image/${file.extension}";
                                    } else {
                                      mimeType = "application/${file.extension}";
                                    }

                                    Map map = {
                                      "originalName": file.name,
                                      "mimeType": mimeType,
                                      "size": file.size,
                                      "url": file.bytes
                                    };
                                    String bodyJson = json.encode(map);

                                    final response = await http.post(
                                      Uri.parse(
                                          'https://api.projetosempapel.com/Boxes/${snapshot.data!.id!}/files'),
                                      body: jsonEncode({
                                        'originalName': file.name,
                                        'mimeType': mimeType,
                                        'size': file.size,
                                        "url": file.path,
                                      }),
                                    );

                                    if (response.statusCode == 200) {
                                      print('Arquivo enviado com sucesso');
                                    } else {
                                      print('Erro ao enviar o arquivo para a API');
                                    }
                                  } catch (erro) {
                                    print('Erro ao processar o arquivo: $erro');
                                  }
                                } else {
                                  ShowSnackBar(context: context, label: "Arquivo não selecionado!");
                                }
                              },
                              child: const Text(
                                'Arraste arquivo(s) ou clique aqui para enviar',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.files!.length,
                        itemBuilder: (context, index) {
                          BoxDice itens = snapshot.data!;
                          return Ink(
                            child: InkWell(
                              onTap: () {
                                context.push('/Files/${itens.files![index].sId}');
                              },
                              child: Column(
                                children: [
                                  Text(
                                    itens.files![index].originalName!,
                                    style:
                                        const TextStyle(fontSize: 18, fontFamily: "Goldplay-black"),
                                  ),
                                  Text(itens.files![index].mimeType!),
                                  const SizedBox(height: 20),
                                  Image.asset('assets/images/quCode.png'),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
