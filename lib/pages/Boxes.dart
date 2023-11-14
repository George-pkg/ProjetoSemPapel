// ignore_for_file: file_names, deprecated_member_use, avoid_print, non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

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
  late ProjectProvider _projectProvider;

  @override
  void initState() {
    super.initState();
    _futureBoxDice = ListBox(widget.id);
    _projectProvider = ProjectProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsPage.whiteSmoke,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/images/psp-background.svg',
              fit: BoxFit.contain,
              color: ColorsPage.green,
              alignment: AlignmentDirectional.bottomStart,
              width: double.infinity,
            ),
          ),
          Scaffold(
            appBar: appBarDaynamic(context),
            backgroundColor: Colors.transparent,
            body: _body(),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            color: Colors.white70,
            padding: const EdgeInsets.only(top: 60),
            child: FutureBuilder(
              future: _futureBoxDice,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      height: 400,
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
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
                                FilePickerResult? result = await FilePicker.platform
                                    .pickFiles(type: FileType.any, withData: true);

                                if (result != null && result.files.isNotEmpty) {
                                  List<int> bytes = result.files.first.bytes!.cast();
                                  var name = result.files.first.name;

                                  if (bytes != null) {
                                    try {
                                      _projectProvider.test(bytes, name, snapshot.data!.id!);
                                      ShowSnackBar(
                                          context: context,
                                          label: "arquivo enviado com sucesso!",
                                          isErro: false);
                                    } catch (error) {
                                      ShowSnackBar(
                                          context: context,
                                          label: "Erro ao enviar arquivo ao servidor!");
                                      print('Erro ao enviar o arquivo: $error');
                                    }
                                  } else {
                                    ShowSnackBar(
                                        context: context,
                                        label: "Erro ao ler arquivo selecionado!");
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

class ProjectProvider {
  // * constructor
  ProjectProvider() : _dio = Dio();

  // * dio
  late Response _response;
  late final Dio _dio;

  // * rest api

  test(List<int> bytes, String name, dynamic id) async {
    String extension = name.split(".").last;

    var formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        bytes,
        filename: name,
        contentType: MediaType("File", extension),
      ),
    });

    _response = await _dio.post("https://api.projetosempapel.com/Boxes/$id/files", data: formData);
  }
}
