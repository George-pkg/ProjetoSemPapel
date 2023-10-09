import 'package:flutter/material.dart';
import 'package:my_app/pages/API.dart';
import 'package:my_app/pages/homePage.dart';
import 'package:my_app/widgets/login.dart';

import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tela de Login',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        getPages: [
          GetPage(name: '/', page: () => const Login(), children: [
            GetPage(name: '/HomePage', page: () => const homePage()),
            GetPage(name: '/HomePage/API', page: () => const API())
          ])
        ]);
  }
}
