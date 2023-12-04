// libs
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// models/utils
import 'package:sem_papel/utils/colors.dart';

AppBar appBarDaynamic(BuildContext context) {
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
              onPressed: () => Get.toNamed('/Login'),
              child: const Icon(Icons.logout, color: ColorsPage.whiteSmoke),
            ),
          ),
        ],
      )
    ],
  );
}
