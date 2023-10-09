import 'package:flutter/material.dart';
import 'package:my_app/models/appBarDynamic.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic()
    );
  }
}