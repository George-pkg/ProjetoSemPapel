import 'package:flutter/material.dart';
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
    );
  }
}
