import 'package:flutter/material.dart';
import 'package:my_app/models/BoxOpen.dart';
import 'package:my_app/models/appBarDynamic.dart';
import 'package:get/get.dart';

class OilShip extends StatefulWidget {
  const OilShip({super.key});

  @override
  State<OilShip> createState() => _OilShipState();
}

class _OilShipState extends State<OilShip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic(),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: Column(
        children: [
          BoxOpen('Oil Ship - F01 NB3002', '../assets/image/navio.png', '/Documents/OilShip')
        ],
      ),
    );
  }
}
