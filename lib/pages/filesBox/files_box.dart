// libs
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:sem_papel/components/show_snackbar.dart';
import 'package:sem_papel/models/comments_models.dart';
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
// controller
import 'package:sem_papel/controller/comments.controller.dart';

class FilesBox extends StatefulWidget {
  const FilesBox({super.key});

  @override
  State<FilesBox> createState() => _FilesBoxState();
}

class _FilesBoxState extends State<FilesBox> {
  final String idFile = Get.parameters['idFile']!;
  late Future<fileJson> futureFile;
  bool isComents = false;
  List<Comments> listComments = [
    Comments(title: 'Comentario teste', description: 'este é um teste')
  ];
  CommentController controller = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    futureFile = fileList(idFile);
  }

  void addComments() async {
    Comments? addComments = await addCommentData(context);

    if (addComments != null) {
      setState(() {
        listComments.add(addComments);
      });
    }
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
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: listComments.length,
                                        itemBuilder: (context, index) => ListTile(
                                          title: Text(listComments[index].title),
                                          subtitle: Text(listComments[index].description),
                                          trailing: TextButton(
                                              onPressed: () =>
                                                  editComments(listComments[index], context),
                                              child: const Icon(Icons.edit)),
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

  Future<Comments?> addCommentData(BuildContext context) async {
    String? title;
    String? description;
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
                  if (title != null && description != null) {
                    Get.back();
                  } else {
                    showSnackBar(context: context, label: "Dados invalidos");
                  }
                },
                child: const Text('OK'),
              )
            ],
          );
        });
    if (title != null && description != null) {
      return Comments(title: title!, description: description!);
    } else {
      return null;
    }
  }

  Future<void> editComments(Comments commentsMod, BuildContext context) async {
    final updatedComment = await showDialog(
        context: context,
        builder: (context) {
          TextEditingController titleController = TextEditingController(text: commentsMod.title);
          TextEditingController descriptionController =
              TextEditingController(text: commentsMod.description);

          return AlertDialog(
            title: const Text('Editar ou deletar um comentario:'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Decoração'),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(ColorsPage.red)),
                child: const Text('Deletar'),
              ),
              ElevatedButton(
                  onPressed: () {
                    final newComment = Comments(
                        title: titleController.text, description: descriptionController.text);
                    Get.back(result: newComment);
                  },
                  child: const Text('Salvar')),
            ],
          );
        });

    if (updatedComment != null) {
      setState(() {
        final index = listComments.indexWhere((item) => item == commentsMod);
        if (index >= 0) {
          listComments[index] = updatedComment;
        }
      });
    }
  }
}
