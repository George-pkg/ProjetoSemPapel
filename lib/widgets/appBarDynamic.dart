import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/utils/colors.dart';

AppBar appBarDaynamic(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: true,
    leading: IconButton(
        onPressed: () => GoRouter.of(context).canPop(), icon: const Icon(Icons.arrow_back_ios_new)),
    backgroundColor: ColorsPage.green,
    actions: [
      ButtonBar(
        children: [
          TextButton(
              onPressed: () => context.go('/NewBox'),
              child: const Icon(
                Icons.add_box_outlined,
                color: ColorsPage.whiteSmoke,
              )),
          TextButton(
              onPressed: () => context.go('/SearchBox'),
              child: const Icon(
                Icons.search,
                color: ColorsPage.whiteSmoke,
              )),
        ],
      )
    ],
  );
}
