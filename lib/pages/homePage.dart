import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/models/BoxOpen.dart';
import 'package:my_app/models/appBarDynamic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDynamic(),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: Center(
            child: Container(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          height: 650,
          width: 900,
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            //  Row top
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              // Conatainer 1 == "Oil Ship - F01 NB3002"
              BoxOpen('Oil Ship - F01 NB3002', '../assets/image/navio.png', '/Documents/OilShip'),
              // Container 2 == "Factory - Robson & Robson"
              BoxOpen('Factory - Robson & Robson', '../assets/image/factory.png',
                  '/Documents/FactoryR&R')
            ]),

            const SizedBox(
              height: 25,
            ),

            // Row bottom
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 203, 208, 228),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                height: 300,
                width: 300,
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Oil Area', style: TextStyle(fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                          SizedBox(height: 150, child: Image.asset('../assets/image/oil_1280.png')),
                    ),
                    TextButton(
                        onPressed: () => Get.toNamed('/Documents/OilArea'),
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                        child: const Text('OPEN', style: TextStyle(color: Colors.black))),
                  ],
                ),
              ),
              Container(
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
            ])
          ]),
        )));
  }
}
