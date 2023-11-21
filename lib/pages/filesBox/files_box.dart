// libs
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// components/widgets
import 'package:my_app/components/api/file_list.dart';
import 'package:my_app/components/appbar_dynamic.dart';
import 'package:my_app/components/qr_gerator.dart';
// models/utils
import 'package:my_app/models/file_json.dart';
import 'package:my_app/utils/colors.dart';
import 'package:my_app/utils/convert_time.dart';
import 'package:my_app/utils/file_size.dart';

class FilesBox extends StatefulWidget {
  const FilesBox({super.key});

  @override
  State<FilesBox> createState() => _FilesBoxState();
}

class _FilesBoxState extends State<FilesBox> {
  final String idFile = Get.parameters['idFile'] ?? 'N/A';
  late Future<fileJson> futureFile;

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
          child: Padding(
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
                            colorFilter: const ColorFilter.mode(ColorsPage.gray, BlendMode.srcATop)
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
          ),
        ));
  }
}
