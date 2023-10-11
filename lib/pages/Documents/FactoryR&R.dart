import 'package:flutter/material.dart';
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
        child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 203, 208, 228),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            height: 300,
            width: 300,
            padding: const EdgeInsets.all(15),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Factory - Robson & Robson', style: TextStyle(fontSize: 20)),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(height: 150, child: Image.asset('../assets/image/factory.png'))),
              TextButton(
                  onPressed: () => Get.toNamed('/Documents/FactoryR&R'),
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  child: const Text('OPEN', style: TextStyle(color: Colors.black)))
            ])),
      ),
    );
  }
}
