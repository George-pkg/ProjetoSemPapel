import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/models/BoxOpen.dart';
import 'package:my_app/models/appBarDynamic.dart';

import '../../models/PainelList.dart';

class OilArea extends StatefulWidget {
  const OilArea({super.key});

  @override
  State<OilArea> createState() => _OilAreaState();
}

class _OilAreaState extends State<OilArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDynamic(context),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: PainelList());
  }
}
