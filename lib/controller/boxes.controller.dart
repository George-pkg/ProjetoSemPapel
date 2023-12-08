// libs
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
// components/widgets
import 'package:master/components/show_snackbar.dart';
import 'package:master/data/dio/upload_file.dart';
import 'package:master/data/http/list_box_api.dart';
// models/utils
import 'package:master/models/box_dice.dart';

class BoxesController extends GetxController {
  final String id;
  late Rx<Future<BoxDice>> futureBoxDice;
  late UploadFile uploadFile;

  BoxesController(this.id) {
    futureBoxDice = Rx<Future<BoxDice>>(Future.value(BoxDice()));
    uploadFile = UploadFile();
    refreshBoxDice();
  }

  // função para atualizar a interface quando o estado muda
  Future<void> refreshBoxDice() async {
    futureBoxDice.value = listBox(id);
    update();
  }

  Future<void> uploadAndRefresh(FilePickerResult result, String id) async {
    final file = result.files.first;
    List<int> bytes = file.bytes!.cast();
    var name = file.name;
    if (result.files.isNotEmpty) {
      try {
        await uploadFile.upload(bytes, name, id, file.extension!);
        refreshBoxDice();
        showSnackBar(context: Get.context!, label: "Arquivo enviado com sucesso!", isErro: false);
      } catch (error) {
        showSnackBar(context: Get.context!, label: "Erro ao enviar arquivo ao servidor!");
      }
    }
  }
}
