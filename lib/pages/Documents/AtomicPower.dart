import 'package:flutter/material.dart';
import 'package:my_app/models/appBarDynamic.dart';
import 'package:get/get.dart';

class AtomicPower extends StatefulWidget {
  const AtomicPower({super.key});

  @override
  State<AtomicPower> createState() => _AtomicPowerState();
}

class _AtomicPowerState extends State<AtomicPower> {
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
                  const Text('Atomic Power Plant', style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                        height: 150,
                        child: Image.asset('../assets/image/atomic-power-plant_1280.png')),
                  ),
                  TextButton(
                      onPressed: () => Get.toNamed('/Documents/AtomicPower'),
                      style:
                          const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                      child: const Text('OPEN', style: TextStyle(color: Colors.black))),
                ]),
              ),
      ),
    );
  }
}