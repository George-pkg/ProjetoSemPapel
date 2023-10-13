import 'package:flutter/material.dart';
import 'package:get/get.dart';

// AppBar na qual seleciona a pagina selecionada

/* 
  OBS: não está otimizada, tem como reduzir o tamanho do codigo e deixa-la mais dinamica,
  entretanto como já tinha escrevido o codigo, foquei em fazer outras funções e voltar aqui depois.
*/
appBarDynamic() {
  var route = Get.currentRoute;

  if (route == '/HomePage') {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("No Papel"),
      backgroundColor: const Color.fromARGB(255, 55, 81, 126),
      actions: <Widget>[
        TextButton(
            onPressed: () => Get.toNamed('/HomePage'),
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.blueAccent),
            )),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            Get.toNamed('/API');
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            Get.toNamed('/Documents');
          },
          child: const Text(
            'Documents',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  } else if (route.contains('/API')) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () => Get.toNamed('/HomePage'), child: const Text("No Papel"))),
      backgroundColor: const Color.fromARGB(255, 55, 81, 126),
      actions: <Widget>[
        TextButton(
            onPressed: () => Get.toNamed('/HomePage'),
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            Get.toNamed('/API');
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            Get.toNamed('/Documents');
          },
          child: const Text(
            'Documents',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  } else if (route.contains('/Documents')) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () => Get.toNamed('/Documents'), icon: const Icon(Icons.arrow_back_ios)),
      title: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () => Get.toNamed('/HomePage'), child: const Text("No Papel"))),
      backgroundColor: const Color.fromARGB(255, 55, 81, 126),
      actions: <Widget>[
        TextButton(
            onPressed: () => Get.toNamed('/HomePage'),
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            Get.toNamed('/API');
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            Get.toNamed('/Documents');
          },
          child: const Text(
            'Documents',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}
