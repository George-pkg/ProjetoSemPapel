import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/models/fileJson.dart';
import 'package:my_app/utils/colors.dart';
import 'package:my_app/widgets/appBarDynamic.dart';
import 'package:http/http.dart' as http;

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
                      Image.asset('assets/images/quCode.png'),
                      const Text('Tipo de aqruivo:',
                          style: TextStyle(fontFamily: "Goldplay-black", fontSize: 19)),
                      Text(file.mimeType!, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      const Text('Tamanho:',
                          style: TextStyle(fontFamily: "Goldplay-black", fontSize: 19)),
                      Text(getFileSizeString(bytes: file.size!),
                          style: const TextStyle(fontSize: 16)),
                      
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    if (bytes == 0) return '0${suffixes[0]}';
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
}
