// libs
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// components/widgets
import 'package:sem_papel/components/appbar_dynamic.dart';
import 'package:sem_papel/components/qr_gerator.dart';
import 'package:sem_papel/data/http/file_list.dart';
// models/utils
import 'package:sem_papel/models/comments_models.dart';
import 'package:sem_papel/utils/convert_time.dart';
import 'package:sem_papel/models/file_json.dart';
import 'package:sem_papel/utils/file_size.dart';
import 'package:sem_papel/utils/colors.dart';
// controller
import 'package:sem_papel/controller/comments.controller.dart';

class FilesBox extends StatefulWidget {
  const FilesBox({super.key});

  @override
  State<FilesBox> createState() => _FilesBoxState();
}

class _FilesBoxState extends State<FilesBox> {
  final String idFile = Get.parameters['idFile']!;
  late Future<FileJson> futureFile;
  CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    futureFile = fileList(idFile);
  }

  void addComments() async {
    Comments? addComments = await _addCommentData();

    if (addComments != null) {
      CommentController controller = Get.find();
      controller.addComment(addComments);
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
                  return Container(
                      alignment: Alignment.center,
                      height: context.mediaQuerySize.height,
                      width: context.mediaQuerySize.width,
                      child: const CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (!snapshot.hasData) {
                  return const Text('No data available');
                } else {
                  FileJson file = snapshot.data!;
                  return Column(
                    children: [
                      _buildFileColumn(file),
                      const SizedBox(height: 40),
                      SizedBox(child: _buildCommentsColumn())
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }

  Widget _buildFileColumn(FileJson file) {
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

  Widget _buildCommentsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
            onPressed: () => commentController.toggleCommentsVisibility(),
            icon: Obx(
              () => Icon(
                  commentController.isComments.value
                      ? Icons.comments_disabled
                      : Icons.comment_rounded,
                  color: ColorsPage.green),
            )),
        Obx(
          () => Visibility(
              visible: commentController.isComments.value,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: commentController.listComments.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (_, index) {
                          Comments itens = commentController.listComments[index];
                          return ListTile(
                            title: Text(itens.title),
                            subtitle: Text(itens.description),
                            trailing: TextButton(
                                onPressed: () => _editComments(itens),
                                child: const Icon(Icons.edit)),
                          );
                        }),
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
        ),
      ],
    );
  }
}

Future<Comments?> _addCommentData() async {
  String? title;
  String? description;
  await Get.defaultDialog(
    title: 'Adicionar um comentário',
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
            Get.snackbar('erro', 'o comentario não pode estar vazio');
          }
        },
        child: const Text('OK'),
      )
    ],
  );

  if (title != null && description != null) {
    return Comments(title: title!, description: description!);
  } else {
    return null;
  }
}

Future<void> _editComments(Comments commentsMod) async {
  TextEditingController titleController = TextEditingController(text: commentsMod.title);
  TextEditingController descriptionController =
      TextEditingController(text: commentsMod.description);

  final updateComment = await Get.defaultDialog(
    title: 'Editar ou deletar um comentario:',
    contentPadding: const EdgeInsets.all(20),
    content: Column(
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
                id: commentsMod.id,
                title: titleController.text,
                description: descriptionController.text);
            if (titleController.text != '' && descriptionController.text != '') {
              Get.back(result: newComment);
            } else {
              Get.snackbar('erro', 'o comentario não ppode estar vazio');
            }
          },
          child: const Text('Salvar')),
    ],
  );
  if (updateComment != null) {
    CommentController controller = Get.find();
    controller.editComment(updateComment, commentsMod);
  }
}
