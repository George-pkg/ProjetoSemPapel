// libs
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
// components/widgets
import 'package:sem_papel/components/show_snackbar.dart';
import 'package:sem_papel/data/dio/upload_file.dart';
import 'package:sem_papel/data/http/list_box_api.dart';
// models/utils
import 'package:sem_papel/models/box_dice.dart';

class BoxesController extends GetxController {
  final String id;
  late Future<BoxDice> futureBoxDice;
  late UploadFile uploadFile;

  BoxesController(this.id) {
    futureBoxDice = listBox(id);
    uploadFile = UploadFile();
  }

  // função para atualizar a interface quando o estado muda
  void refreshBoxDice() {
    futureBoxDice = listBox(id);
    update(); 
  }

  Future<void> uploadAndRefresh(FilePickerResult result, String id) async {
    final file = result.files.first;
    List<int> bytes = file.bytes!.cast();
    var name = file.name;
    try {
      await uploadFile.test(bytes, name, id, file.extension!);
      refreshBoxDice();
      showSnackBar(context: Get.context!, label: "Arquivo enviado com sucesso!", isErro: false);
    } catch (error) {
      showSnackBar(context: Get.context!, label: "Erro ao enviar arquivo ao servidor!");
    }
  }
}
