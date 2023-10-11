import 'package:flutter/material.dart';
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
    );
  }
}