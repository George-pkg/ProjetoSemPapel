import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/utils/colors.dart';

AppBar appBarDaynamic(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: ColorsPage.green,
    actions: [
      ButtonBar(
        children: [
          TextButton(
              onPressed: () => context.go('/HomePage'),
              child: const Text('Criar', style: TextStyle(color: ColorsPage.whiteSmoke))),
          TextButton(
              onPressed: () {},
              child: const Text('Procurar', style: TextStyle(color: ColorsPage.whiteSmoke)))
        ],
      )
    ],
  );
}
