import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/utils/colors.dart';

AppBar appBarDaynamic(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: true,
    leading: IconButton(
        onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new)),
    backgroundColor: ColorsPage.green,
    actions: [
      ButtonBar(
        children: [
          TextButton(
              onPressed: () => context.go('/NewBox'),
              child: const Text('Criar', style: TextStyle(color: ColorsPage.whiteSmoke))),
          TextButton(
              onPressed: () => context.go('/SearchBox'),
              child: const Text('Procurar', style: TextStyle(color: ColorsPage.whiteSmoke)))
        ],
      )
    ],
  );
}
