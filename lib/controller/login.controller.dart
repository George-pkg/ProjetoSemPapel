import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs; // Variável observável para o nome de usuário
  var password = ''.obs; // Variável observável para a senha

  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  // Função para validar o login
  bool validateLogin() {
    // Verifica se o usuário e a senha estão corretos (implemente sua lógica aqui)
    if (email.value == 'usuario' && password.value == 'senha') {
      // Se estiverem corretos, retorna true
      return true;
    } else {
      // Se estiverem incorretos, retorna false
      return false;
    }
  }
}