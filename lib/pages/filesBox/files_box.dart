// libs
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// components/widgets
import 'package:sem_papel/components/api/file_list.dart';
import 'package:sem_papel/components/appbar_dynamic.dart';
import 'package:sem_papel/components/qr_gerator.dart';
// models/utils
import 'package:sem_papel/models/file_json.dart';
import 'package:sem_papel/utils/colors.dart';
import 'package:sem_papel/utils/convert_time.dart';
import 'package:sem_papel/utils/file_size.dart';

class FilesBox extends StatefulWidget {
  const FilesBox({super.key});

  @override
  State<FilesBox> createState() => _FilesBoxState();
}

class _FilesBoxState extends State<FilesBox> {
  final String idFile = Get.parameters['idFile'] ?? 'N/A';
  late Future<fileJson> futureFile;
  bool isComents = false;

  @override
  void initState() {
    super.initState();
    futureFile = fileList(idFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDaynamic(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: FutureBuilder(
              future: futureFile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: const CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (!snapshot.hasData) {
                  return const Text('No data available');
                } else {
                  fileJson file = snapshot.data!;
                  return Row(
                    children: [
                      Expanded(
                        child: columFile(file),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextButton(
                                onPressed: () => isComents = !isComents,
                                child: const Icon(Icons.comment_rounded))
                          ],
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }

  Widget columFile(file) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SvgPicture.asset('assets/images/psp-logo.svg',
              width: 250, colorFilter: const ColorFilter.mode(ColorsPage.gray, BlendMode.srcATop)),
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
        const Text('Tamanho:', style: TextStyle(fontFamily: "Goldplay-black", fontSize: 19)),
        Text(getFileSizeString(bytes: file.size!), style: const TextStyle(fontSize: 16)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(convertTime(file.updatedAt!),
              style: const TextStyle(
                  color: ColorsPage.green, fontSize: 18, fontFamily: "Goldplay-black")),
        ),
        ElevatedButton(
            onPressed: () => launchUrl(Uri.parse(file.url!)), child: const Text('Abrir')),
      ],
    );
  }
}
