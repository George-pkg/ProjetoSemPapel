// libs
import 'package:flutter/material.dart';
// pages
import 'package:my_app/pages/home/home_desktop.dart';
import 'package:my_app/pages/home/home_mobile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 700) {
        return const HomeMobile();
      } else {
        return const HomeDesktop();
      }
    });
  }
}
