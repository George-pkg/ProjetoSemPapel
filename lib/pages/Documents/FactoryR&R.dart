import 'package:flutter/material.dart';
import 'package:my_app/models/appBarDynamic.dart';

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
    );
  }
}