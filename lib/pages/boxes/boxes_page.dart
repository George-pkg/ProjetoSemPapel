// libs
import 'package:get/get.dart';
import 'package:flutter/material.dart';
// pages
import 'package:sem_papel/pages/boxes/boxes_desktop.dart';
import 'package:sem_papel/pages/boxes/boxes_mobile.dart';

class Boxes extends StatefulWidget {
  const Boxes({Key? key}) : super(key: key);

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  final String id = Get.parameters['id']!;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 700;
          return isDesktop ? BoxesDesktop(id: id) : BoxesMobile(id: id);
        },
      );
}
