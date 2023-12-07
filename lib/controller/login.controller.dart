import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isUsuarioAutenticado = false.obs;

  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  // Função para validar o login
  bool validateLogin() {
    if (email.value.contains("@gmail.com") && password.value == '12345678') {
      // Se estiverem corretos, retorna true
      isUsuarioAutenticado.value = true;
      return true;
    } else {
      // Se estiverem incorretos, retorna false
      return false;
    }
  }

  void fazerLogin() {
    isUsuarioAutenticado.value = true;
  }

  void fazerLogout() {
    isUsuarioAutenticado.value = false;
  }
}
