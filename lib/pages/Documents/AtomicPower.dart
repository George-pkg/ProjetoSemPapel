import 'package:flutter/material.dart';
import 'package:my_app/models/BoxOpen.dart';
import 'package:my_app/models/appBarDynamic.dart';

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
        child: BoxOpen('Atomic Power Plant', '../assets/image/atomic-power-plant_1280.png',
                  '/Documents/AtomicPower')
      ),
    );
  }
}