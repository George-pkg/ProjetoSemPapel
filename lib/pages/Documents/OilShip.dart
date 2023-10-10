import 'package:flutter/material.dart';
import 'package:my_app/models/appBarDynamic.dart';

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
    );
  }
}