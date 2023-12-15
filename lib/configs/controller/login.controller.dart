import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isUsuarioAutenticado = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAuthState();
  }

  // Pegar dados do email e password
  void setEmail(String value) => email.value = value;
  void setPassword(String value) => password.value = value;

  // Função para validar o login
  bool validateLogin() {
    bool isValid = email.value.contains("@gmail.com") && password.value == '12345678';
    if (isValid) {
      fazerLogin();
      return true;
    }
    return false;
  }

  void fazerLogin() {
    isUsuarioAutenticado.value = true;
    _saveAuthState(true);
  }

  void fazerLogout() {
    isUsuarioAutenticado.value = false;
    _saveAuthState(false);
  }

  Future<void> _saveAuthState(bool isAuthenticated) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', isAuthenticated);
  }

   Future<void> _loadAuthState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    isUsuarioAutenticado.value = isAuthenticated;
  }
}
