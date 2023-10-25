import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/models/BoxOpen.dart';
import 'package:my_app/models/appBarDynamic.dart';

class Documents extends StatefulWidget {
  const Documents({super.key, String? id});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDynamic(context),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: Center(
            child: Container(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),

          width: 900,
          child: Column(mainAxisSize: MainAxisSize.max, children: [
              //  Row top
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                // Conatainer 1 == "Oil Ship - F01 NB3002"
                BoxOpen('Oil Ship - F01 NB3002', '../assets/image/navio.png', '/Documents/list'),
                // Container 2 == "Factory - Robson & Robson"
                BoxOpen('Factory - Robson & Robson', '../assets/image/factory.png',
                    '/Documents/FactoryR&R')
              ]),

              const SizedBox(
                height: 25,
              ),

              // Row bottom
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                BoxOpen('Oil Area', '../assets/image/oil_1280.png', '/Documents/OilArea'),
                BoxOpen('Atomic Power Plant', '../assets/image/atomic-power-plant_1280.png',
                    '/Documents/AtomicPower')
              ]),
            ]),
        )));
  }
}
