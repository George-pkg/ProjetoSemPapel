// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/components/appBarDynamic.dart';
import 'package:my_app/components/qr_gerator.dart';
import 'package:my_app/models/fileJson.dart';
import 'package:my_app/utils/colors.dart';
import 'package:my_app/utils/convert_time.dart';
import 'package:my_app/utils/file_size.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<fileJson> File(idFile) async {
  final response = await http.get(Uri.parse('https://api.projetosempapel.com/files/$idFile'));

  if (response.statusCode == 200) {
    return fileJson.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('erro ao conectar ao servidor');
  }
}

class filesBox extends StatefulWidget {
  dynamic idFile;

  filesBox({super.key, required this.idFile});

  @override
  State<filesBox> createState() => _filesBoxState();
}

class _filesBoxState extends State<filesBox> {
  late Future<fileJson> futureFile;

  @override
  void initState() {
    super.initState();
    futureFile = File(widget.idFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDaynamic(context),
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 50),
          child: Center(
            child: FutureBuilder(
              future: futureFile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (!snapshot.hasData) {
                  return const Text('No data available');
                } else {
                  fileJson file = snapshot.data!;
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
                        file.originalName!,
                        style: const TextStyle(
                          fontFamily: "Goldplay-black",
                          fontSize: 18,
                          color: ColorsPage.blueDark,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: QrGerator(file.url!, 180),
                      ),
                      const Text('Tipo de aqruivo:',
                          style: TextStyle(fontFamily: "Goldplay-black", fontSize: 19)),
                      Text(file.mimeType!, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      const Text('Tamanho:',
                          style: TextStyle(fontFamily: "Goldplay-black", fontSize: 19)),
                      Text(getFileSizeString(bytes: file.size!),
                          style: const TextStyle(fontSize: 16)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(convertTime(file.updatedAt!),
                            style: const TextStyle(
                                color: ColorsPage.green,
                                fontSize: 18,
                                fontFamily: "Goldplay-black")),
                      ),
                      ElevatedButton(
                          onPressed: () => launchUrl(Uri.parse(file.url!)),
                          child: const Text('Abrir'))
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }
}
