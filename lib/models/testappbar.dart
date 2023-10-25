import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/widgets/routes.dart';

// AppBar na qual seleciona a pagina selecionada

/* 
  OBS: não está otimizada, tem como reduzir o tamanho do codigo e deixa-la mais dinamica,
  entretanto como já tinha escrevido o codigo, foquei em fazer outras funções e voltar aqui depois.
*/
appdar() {
  var route = '/HomePage';

  if (route == '/HomePage') {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("No Papel"),
      backgroundColor: const Color.fromARGB(255, 55, 81, 126),
      actions: <Widget>[
        TextButton(
            onPressed: () {},
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.blueAccent),
            )),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            GoRouter.of(context as BuildContext).push('/Documents');
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
              onTap: () => GoRouter.of(context as BuildContext).push('/HomePage'),
              child: const Text("No Papel"))),
      backgroundColor: const Color.fromARGB(255, 55, 81, 126),
      actions: <Widget>[
        TextButton(
            onPressed: () => GoRouter.of(context as BuildContext).push('/HomePage'),
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            GoRouter.of(context as BuildContext).push('/API');
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            GoRouter.of(context as BuildContext).push('/Documents');
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
          onPressed: () => GoRouter.of(context as BuildContext).push('/Documents'),
          icon: const Icon(Icons.arrow_back_ios)),
      title: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () => GoRouter.of(context as BuildContext).push('/HomePage'),
              child: const Text("No Papel"))),
      backgroundColor: const Color.fromARGB(255, 55, 81, 126),
      actions: <Widget>[
        TextButton(
            onPressed: () => GoRouter.of(context as BuildContext).push('/HomePage'),
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            GoRouter.of(context as BuildContext).push('/API');
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            GoRouter.of(context as BuildContext).push('/Documents');
          },
          child: const Text(
            'Documents',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  } else {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () => GoRouter.of(context as BuildContext).push('/Documents'),
          icon: const Icon(Icons.arrow_back_ios)),
      title: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () => GoRouter.of(context as BuildContext).push('/HomePage'),
              child: const Text("No Papel"))),
      backgroundColor: const Color.fromARGB(255, 55, 81, 126),
      actions: <Widget>[
        TextButton(
            onPressed: () => GoRouter.of(context as BuildContext).push('/HomePage'),
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            GoRouter.of(context as BuildContext).push('/API');
          },
          child: const Text(
            'API',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: const ButtonStyle(),
          onPressed: () {
            GoRouter.of(context as BuildContext).push('/Documents');
          },
          child: const Text(
            'Documents',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
