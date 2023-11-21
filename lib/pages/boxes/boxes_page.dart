// libs
import 'package:get/get.dart';
import 'package:flutter/material.dart';
// pages
import 'package:my_app/pages/boxes/boxes_desktop.dart';
import 'package:my_app/pages/boxes/boxes_mobile.dart';

class Boxes extends StatefulWidget {
  const Boxes({Key? key}) : super(key: key);

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  final String id = Get.parameters['id'] ?? 'N/A';

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return BoxesDesktop(id: id);
          } else {
            return BoxesMobile(id: id);
          }
        },
      );
}
