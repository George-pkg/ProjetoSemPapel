import 'package:flutter/material.dart';
import 'package:my_app/pages/API.dart';
import 'package:my_app/pages/Documents.dart';
import 'package:my_app/pages/Documents/FactoryR&R.dart';
import 'package:my_app/pages/Documents/OilShip.dart';
import 'package:my_app/pages/HomePage.dart';
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

        // gestor de paginas
        getPages: [
          GetPage(name: '/', page: () => const Login(), children: [
            GetPage(name: '/HomePage', page: () => const HomePage()),
            GetPage(name: '/API', page: () => const API()),
            GetPage(name: '/Documents', page: () => const Documents(), children: [
              GetPage(name: '/OilShip', page: () => const OilShip()),
              GetPage(name: '/FactoryR&R', page: () => const FactoryReR())
            ])
          ])
        ]);
  }
}
