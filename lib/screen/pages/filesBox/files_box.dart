// libs
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:master/screen/components/decoration_input.dart';
// components/widgets
import 'package:master/data/http/file_list.dart';
import 'package:master/screen/components/qr_gerator.dart';
import 'package:master/screen/components/appbar_dynamic.dart';
// models/utils
import 'package:master/utils/colors.dart';
import 'package:master/utils/file_size.dart';
import 'package:master/models/file_json.dart';
import 'package:master/utils/convert_time.dart';
import 'package:master/models/comments_models.dart';
// controller\settings
import 'package:master/configs/settings/userlocal_settings.dart';
import 'package:master/configs/controller/comments.controller.dart';

class FilesBox extends StatefulWidget {
  const FilesBox({super.key});

  @override
  State<FilesBox> createState() => _FilesBoxState();
}

class _FilesBoxState extends State<FilesBox> {
  // variables
  final String idFile = Get.parameters['idFile']!;
  late Future<FileJson> futureFile;
  CommentController commentController = Get.put(CommentController());
  late Map<String, String> userDataFuture;

  // starting variables
  @override
  void initState() {
    super.initState();
    futureFile = fileList(idFile);
    _userDataFuture();
  }

  // function for get readLocal
  void _userDataFuture() async {
    userDataFuture = await UserLocal().readLocal();
  }

  // function for add comment
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
        appBar: appBarDaynamic(),
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
                  return Column(
                    children: [
                      const Text('Sem conexão de internet',
                          style: TextStyle(fontFamily: "Goldplay-black")),
                      Image.asset('./assets/images/no_internet.png', height: 400),
                    ],
                  );
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
            onPressed: () => launchUrl(Uri.parse(file.url!)),
            child: const Text('Abrir', style: TextStyle(color: Colors.white))),
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
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: commentController.listComments.length,
                        itemBuilder: (_, index) {
                          Comments itens = commentController.listComments[index];
                          bool isUserComment = itens.name == userDataFuture['name'];
                          return ListTile(
                            leading: CircleAvatar(backgroundImage: NetworkImage(itens.photoUrl)),
                            title: Text(itens.modified
                                ? "${itens.name} editou o comentario:"
                                : "${itens.name} comentou:"),
                            subtitle: Text(itens.description),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isUserComment)
                                  TextButton(
                                      onPressed: () => _editComments(itens),
                                      child: const Icon(Icons.edit)),
                                Text(commentController.timeToString(itens.time!)),
                              ],
                            ),
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

  Future<Comments?> _addCommentData() async {
    String? title;
    String? description;
    await Get.defaultDialog(
      title: 'Adicionar um comentário',
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.all(20),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          decoration:
              decorationInput('Título', ColorsPage.green, const Color.fromARGB(255, 0, 78, 28)),
          onChanged: (value) => title = value,
        ),
        const SizedBox(height: 15),
        TextField(
          decoration: decorationInput('Descrição', ColorsPage.green, ColorsPage.greenDark),
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
            if (title == null && description == null) {
              Get.snackbar('erro', 'o comentario não pode estar vazio');
            }
            Get.back();
          },
          child: const Text('OK'),
        )
      ],
    );

    if (title != null && description != null) {
      return Comments(
          title: title!,
          description: description!,
          photoUrl: userDataFuture['photoUrl']!,
          name: userDataFuture['name']!);
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
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: decorationInput('Título', ColorsPage.green, ColorsPage.greenDark),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: descriptionController,
            decoration: decorationInput('Descrição', ColorsPage.green, ColorsPage.greenDark),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            CommentController controller = Get.find();
            controller.deleteComment(commentsMod);
            Get.back();
          },
          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(ColorsPage.red)),
          child: const Text('Deletar'),
        ),
        ElevatedButton(
            onPressed: () {
              final newComment = Comments(
                id: commentsMod.id,
                title: titleController.text,
                description: descriptionController.text,
                photoUrl: commentsMod.photoUrl,
                name: commentsMod.name,
                modified: true,
              );
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
}
