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
  late int test = 0;
  List<Comments> comments = [Comments(title: 'Comentario teste', description: 'este é um teste')];

  @override
  void initState() {
    super.initState();
    futureFile = fileList(idFile);
  }

  void addComments() async {
    Comments? addComments = await addCommentData(context);

    setState(() {
      comments.add(addComments!);
    });
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
                  return Column(
                    children: [
                      columFile(file),
                      const SizedBox(height: 40),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                                onPressed: () => setState(() => isComents = !isComents),
                                icon: Icon(
                                    isComents ? Icons.comments_disabled : Icons.comment_rounded,
                                    color: ColorsPage.green)),
                            Visibility(
                                visible: isComents,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 800),
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: comments.length,
                                        itemBuilder: (context, index) => ListTile(
                                          title: Text(comments[index].title),
                                          subtitle: Text(comments[index].description),
                                          trailing: TextButton(
                                              onPressed: () => setState(() => ()),
                                              child: Icon(Icons.edit)),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            addComments();
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: ColorsPage.green,
                                            size: 30,
                                          ))
                                    ],
                                  ),
                                )),
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

class Comments {
  final String title;
  final String description;

  Comments({required this.title, required this.description});
}

Future<Comments?> addCommentData(BuildContext context) async {
  late String title;
  late String description;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar um comentário'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Titulo:'),
              onChanged: (value) => title = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Descrição:'),
              onChanged: (value) => description = value,
            )
          ]),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Voltar'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            )
          ],
        );
      });
  try {
    return Comments(title: title, description: description);
  } catch (e) {
    return null;
  }
}
