// libs
import 'package:get/get.dart';
import 'package:flutter/material.dart';
//pages
import 'package:master/routes/pages.dart';
import 'package:master/theme/app_theme.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sem Papel',
      theme: AppTheme.getAppTheme(),
      initialRoute: Pages.initial,
      getPages: Pages.routes,
      defaultTransition: Transition.fade,
    ),
  );
}