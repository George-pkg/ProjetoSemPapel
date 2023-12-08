// libs
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master/routes/pages.dart';
//pages
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
