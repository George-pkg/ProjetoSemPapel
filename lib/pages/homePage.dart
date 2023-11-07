import 'package:flutter/material.dart';
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
    return LayoutBuilder(builder: (context, constraints) {
      final bool isMobile = constraints.maxWidth < 650;

      return Scaffold(
          appBar: appBarDynamic(context),
          backgroundColor: const Color.fromARGB(255, 242, 240, 248),
          body: isMobile
              ? SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BoxOpen('Oil Ship - F01 NB3002', 'http://127.0.0.1:5000/navio.png',
                            '/Documents/list'),
                        BoxOpen('Factory - Robson & Robson', 'http://127.0.0.1:5000/factory.png',
                            '/Documents/list'),
                        BoxOpen(
                            'Oil Area', 'http://127.0.0.1:5000/oil_1280.png', '/Documents/list'),
                        BoxOpen('Atomic Power Plant',
                            'http://127.0.0.1:5000/atomic-power-plant_1280.png', '/Documents/list'),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Container(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  width: 900,
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    //  Row top
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      // Conatainer 1 == "Oil Ship - F01 NB3002"
                      BoxOpen('Oil Ship - F01 NB3002', 'http://127.0.0.1:5000/navio.png',
                          '/Documents/list'),
                      // Container 2 == "Factory - Robson & Robson"
                      BoxOpen('Factory - Robson & Robson', 'http://127.0.0.1:5000/factory.png',
                          '/Documents/list')
                    ]),

                    const SizedBox(
                      height: 25,
                    ),

                    // Row bottom
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      BoxOpen('Oil Area', 'http://127.0.0.1:5000/oil_1280.png', '/Documents/list'),
                      BoxOpen('Atomic Power Plant',
                          'http://127.0.0.1:5000/atomic-power-plant_1280.png', '/Documents/list')
                    ]),
                  ]),
                )));
    });
  }
}
