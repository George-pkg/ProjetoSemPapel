// ignore_for_file: use_build_context_synchronously, avoid_print

// libs
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
// components/widgets
import 'package:sem_papel/components/api/list_box_api.dart';
import 'package:sem_papel/components/api/upload_file.dart';
import 'package:sem_papel/components/appbar_dynamic.dart';
import 'package:sem_papel/components/backgroud/backgroud.dart';
import 'package:sem_papel/components/qr_gerator.dart';
import 'package:sem_papel/components/show_snackbar.dart';
// models/utils
import 'package:sem_papel/models/box_dice.dart';
import 'package:sem_papel/utils/colors.dart';
import 'package:sem_papel/utils/convert_time.dart';
import 'package:sem_papel/utils/file_size.dart';

class BoxesDesktop extends StatefulWidget {
  final dynamic id;
  const BoxesDesktop({super.key, required this.id});

  @override
  State<BoxesDesktop> createState() => _BoxesDesktopState();
}

class _BoxesDesktopState extends State<BoxesDesktop> {
  late Future<BoxDice> _futureBoxDice;
  late UploadFile _uploadFile;

  @override
  void initState() {
    super.initState();
    _futureBoxDice = listBox(widget.id);
    _uploadFile = UploadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsPage.whiteSmoke,
      child: Stack(
        children: [
          deskotBackgroud(context),
          Scaffold(
            appBar: appBarDaynamic(context),
            backgroundColor: Colors.transparent,
            body: _body(),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          color: Colors.white70,
          padding: const EdgeInsets.only(top: 60),
          child: FutureBuilder(
            future: _futureBoxDice,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                    height: 400, child: Center(child: CircularProgressIndicator()));
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
                        colorFilter: const ColorFilter.mode(ColorsPage.gray, BlendMode.srcATop),
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
                    QrGerator("/Boxes/${widget.id}", 180),
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

                              final file = result!.files.first;

                              if (result.files.isNotEmpty) {
                                List<int> bytes = file.bytes!.cast();
                                var name = file.name;

                                try {
                                  await _uploadFile.test(bytes, name, widget.id, file.extension!);

                                  // Atualiza os dados da caixa após o envio bem-sucedido do arquivo
                                  setState(() {
                                    _futureBoxDice = listBox(widget.id);
                                  });
                                  showSnackBar(
                                      context: context,
                                      label: "arquivo enviado com sucesso!",
                                      isErro: false);
                                } catch (error) {
                                  showSnackBar(
                                      context: context,
                                      label: "Erro ao enviar arquivo ao servidor!");
                                  print('Erro ao enviar o arquivo: $error');
                                }
                              } else {
                                showSnackBar(context: context, label: "Arquivo não selecionado!");
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
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed('/Files/${itens.files![index].sId}');
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        itens.files![index].originalName!,
                                        style: const TextStyle(
                                            fontSize: 22, fontFamily: "Goldplay-black"),
                                      ),
                                      Text(itens.files![index].mimeType!),
                                      Text(getFileSizeString(bytes: itens.files![index].size!)),
                                      const SizedBox(height: 10),
                                      Text(convertTime(itens.files![index].updatedAt!),
                                          style: const TextStyle(
                                              color: ColorsPage.green,
                                              fontFamily: "Goldplay-black",
                                              fontSize: 13)),
                                      const SizedBox(height: 50),
                                    ],
                                  ),
                                ),
                                QrGerator(itens.files![index].url!, 140),
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
    );
  }
}
