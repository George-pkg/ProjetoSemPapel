import 'package:flutter/material.dart';
import 'package:my_app/models/BoxOpen.dart';
import 'package:my_app/models/appBarDynamic.dart';

class OilArea extends StatefulWidget {
  const OilArea({super.key});

  @override
  State<OilArea> createState() => _OilAreaState();
}

class _OilAreaState extends State<OilArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic(),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: Center(
        child: BoxOpen('Oil Area', '../assets/image/oil_1280.png', '/Documents/OilArea'),
      ),
    );
  }
}
