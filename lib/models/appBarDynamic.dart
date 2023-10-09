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
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      ),
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
            Get.toNamed('/HomePage/API');
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            Get.toNamed('/HomePage/Documents');
          },
          child: const Text(
            'Documents',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  } else if (route == '/HomePage/API') {
    return AppBar(
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
            Get.toNamed('/HomePage/API');
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            Get.toNamed('/HomePage/Documents');
          },
          child: const Text(
            'Documents',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  } else if (route == '/HomePage/Documents') {
    return AppBar(
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
            Get.toNamed('/HomePage/API');
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            Get.toNamed('/HomePage/Documents');
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
