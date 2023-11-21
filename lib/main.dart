// libs
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
//pages
import 'package:my_app/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sem Papel',
      theme: ThemeData(primarySwatch: Colors.green),
      getPages: Routes.routes,
    );
  }
}
