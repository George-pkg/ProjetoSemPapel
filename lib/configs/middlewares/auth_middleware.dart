import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master/configs/controller/login.controller.dart';
import 'package:master/routes/pages.dart';

class AuthMiddleware extends GetMiddleware {
  LoginController loginControllers = Get.put(LoginController());
  // LoginController loginControllers = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (route == Routes.login || route == Routes.qrScan) {
      return null;
    } else if (loginControllers.isUsuarioAutenticado.value == false) {
      return const RouteSettings(name: Routes.login);
    } else {
      return null;
    }
  }
}
