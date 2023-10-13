import 'package:flutter/material.dart';
import 'package:my_app/models/BoxOpen.dart';
import 'package:my_app/models/appBarDynamic.dart';
import 'package:get/get.dart';

class FactoryReR extends StatefulWidget {
  const FactoryReR({super.key});

  @override
  State<FactoryReR> createState() => _FactoryReRState();
}

class _FactoryReRState extends State<FactoryReR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic(),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: Center(
        child: BoxOpen('Factory - Robson & Robson', '../assets/image/factory.png',
                  '/Documents/FactoryR&R')
      ),
    );
  }
}
