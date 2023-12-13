// libs
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:master/data/api/google/google_sing_in_api.dart';
// models/utils
import 'package:master/utils/colors.dart';
// controller
import 'package:master/configs/controller/login.controller.dart';

AppBar appBarDaynamic(BuildContext context) {
  final LoginController loginController = Get.put(LoginController());
  bool loginValue = loginController.isUsuarioAutenticado.value;

  return AppBar(
    automaticallyImplyLeading: true,
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
        color: Colors.white),
    title: IconButton(
        onPressed: () {
          Get.toNamed('/');
        },
        icon: const Icon(Icons.home),
        color: Colors.white),
    backgroundColor: ColorsPage.green,
    actions: [
      ButtonBar(
        children: [
          SizedBox(
            width: 40,
            child: TextButton(
                onPressed: () => Get.toNamed('/NewBox'),
                child: const Icon(
                  Icons.add_box_outlined,
                  color: ColorsPage.whiteSmoke,
                )),
          ),
          SizedBox(
            width: 40,
            child: TextButton(
                onPressed: () => Get.toNamed('/SearchBox'),
                child: const Icon(
                  Icons.search,
                  color: ColorsPage.whiteSmoke,
                )),
          ),
          SizedBox(
            width: 40,
            child: TextButton(
                onPressed: () {
                  Get.toNamed('/QrScan');
                },
                child: const Icon(
                  Icons.photo_camera,
                  color: ColorsPage.whiteSmoke,
                )),
          ),
          SizedBox(
            width: 40,
            child: TextButton(
              onPressed: () {
                loginValue ? logout() : Get.toNamed('/Login');
              },
              child: Icon(loginValue ? Icons.logout : Icons.login, color: ColorsPage.whiteSmoke),
            ),
          ),
        ],
      )
    ],
  );
}

Future<void> logout() {
  final LoginController loginController = Get.put(LoginController());

  return Get.defaultDialog(
      content: const Column(
        children: [
          Text('tem certeza que deseja sair?'),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Sair'),
          onPressed: () {
            loginController.fazerLogout();
            GoogleSingInApi.logout();
            Get.toNamed('/Login');
          },
        ),
      ]);
}
