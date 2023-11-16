// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/utils/colors.dart';

AppBar appBarDaynamic(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: true,
    leading: IconButton(
        onPressed: () {
        },
        icon: const Icon(Icons.arrow_back_ios_new)),
    backgroundColor: ColorsPage.green,
    actions: [
      ButtonBar(
        children: [
          SizedBox(
            width: 40,
            child: TextButton(
                onPressed: () => context.push('/NewBox'),
                child: const Icon(
                  Icons.add_box_outlined,
                  color: ColorsPage.whiteSmoke,
                )),
          ),
          SizedBox(
            width: 40,
            child: TextButton(
                onPressed: () => context.push('/SearchBox'),
                child: const Icon(
                  Icons.search,
                  color: ColorsPage.whiteSmoke,
                )),
          ),
          SizedBox(
            width: 40,
            child: TextButton(
                onPressed: () {
                  context.push('/QrScan');
                },
                child: const Icon(
                  Icons.photo_camera,
                  color: ColorsPage.whiteSmoke,
                )),
          ),
          SizedBox(
            width: 40,
            child: TextButton(
              onPressed: () => context.push('/Login'),
              child: const Icon(Icons.logout, color: ColorsPage.whiteSmoke),
            ),
          ),
        ],
      )
    ],
  );
}
