// libs
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:sem_papel/controller/boxes.controller.dart';
// components/widgets
import 'package:sem_papel/components/appbar_dynamic.dart';
import 'package:sem_papel/components/backgroud/backgroud.dart';
import 'package:sem_papel/components/qr_gerator.dart';
import 'package:sem_papel/components/show_snackbar.dart';
// models/utils
import 'package:sem_papel/models/box_dice.dart';
import 'package:sem_papel/utils/colors.dart';
import 'package:sem_papel/utils/convert_time.dart';
import 'package:sem_papel/utils/file_size.dart';

class Boxes extends StatefulWidget {
  const Boxes({super.key});

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  late String id;
  late BoxesController controller;

  @override
  void initState() {
    super.initState();
    id = Get.parameters['id']!;
    controller = Get.put(BoxesController(id));
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 700;

          return Container(
            color: ColorsPage.whiteSmoke,
            child: Stack(
              children: [
                isDesktop ? deskotBackgroud() : mobileBackgroud(),
                Scaffold(
                  appBar: appBarDaynamic(context),
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Center(
                      child: Container(
                        width: isDesktop
                            ? MediaQuery.of(context).size.width * 0.7
                            : MediaQuery.of(context).size.width * 0.95,
                        color: Colors.white70,
                        padding: const EdgeInsets.only(top: 60),
                        child: Obx(() => _buildBody(isDesktop)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );

  Widget _buildBody(bool isDesktop) {
    return FutureBuilder(
      future: controller.futureBoxDice.value,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 400,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return _buildContent(snapshot.data!, isDesktop);
        }
      },
    );
  }

  Widget _buildContent(BoxDice data, bool isDesktop) {
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
          data.title!,
          style: const TextStyle(
            fontFamily: "Goldplay-black",
            fontSize: 25,
            color: ColorsPage.blueDark,
          ),
        ),
        QrGerator("/Boxes/$id", 180),
        Padding(
          padding: const EdgeInsets.all(15),
          child: _buildFilePickerButton(),
        ),
        _buildFileList(data, isDesktop),
      ],
    );
  }

  Widget _buildFilePickerButton() {
    return DottedBorder(
      color: ColorsPage.greenDark,
      strokeWidth: 1.1,
      child: SizedBox(
        height: 100,
        width: 500,
        child: TextButton(
          onPressed: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(type: FileType.any, withData: true);
            try {
              controller.uploadAndRefresh(result!, id);
              return;
            } catch (e) {
              showSnackBar(context: Get.context!, label: "Arquivo não selecionado!");
            }
          },
          child: const Text(
            'Arraste arquivo(s) ou clique aqui para enviar',
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
    );
  }

  Widget _buildFileList(BoxDice data, bool isDesktop) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.files!.length,
      itemBuilder: (context, index) {
        final file = data.files![index];
        return isDesktop ? _listDesktop(file) : _listMobile(file);
      },
    );
  }

  Widget _listMobile(Files file) {
    return Ink(
      child: InkWell(
        onTap: () {
          Get.toNamed('/Files/${file.sId}');
        },
        child: Column(
          children: [
            Text(
              file.originalName!,
              style: const TextStyle(fontSize: 18, fontFamily: "Goldplay-black"),
            ),
            Text(file.mimeType!),
            Text(getFileSizeString(bytes: file.size!)),
            const SizedBox(height: 10),
            Text(convertTime(file.updatedAt!),
                style: const TextStyle(
                    color: ColorsPage.green, fontFamily: "Goldplay-black", fontSize: 13)),
            const SizedBox(height: 10),
            QrGerator(file.url!, 140),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _listDesktop(Files file) {
    return Ink(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: InkWell(
        onTap: () {
          Get.toNamed('/Files/${file.sId}');
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
                    file.originalName!,
                    style: const TextStyle(fontSize: 22, fontFamily: "Goldplay-black"),
                  ),
                  Text(file.mimeType!),
                  Text(getFileSizeString(bytes: file.size!)),
                  const SizedBox(height: 10),
                  Text(
                    convertTime(file.updatedAt!),
                    style: const TextStyle(
                      color: ColorsPage.green,
                      fontFamily: "Goldplay-black",
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            QrGerator(file.url!, 140),
          ],
        ),
      ),
    );
  }
}
