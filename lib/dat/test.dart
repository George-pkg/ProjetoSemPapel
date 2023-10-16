import 'package:flutter/material.dart';

import 'package:my_app/models/appBarDynamic.dart';

class OilShip extends StatefulWidget {
  const OilShip({super.key});

  @override
  State<OilShip> createState() => _OilShipState();
}

class _OilShipState extends State<OilShip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDynamic(),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: Column(
        children: [
          Flexible(
            flex: 10,
            child: ListView.separated(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 15, bottom: 20),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.asset('../assets/image/folder.png', height: 40),
                  title: Text('Pasta $index'),
                  onTap: () {
                    // print(index);
                  },
                );
              },
              separatorBuilder: (__, _) => const Divider(),
              itemCount: 21,
            ),
          )
        ],
      ),
    );
  }
}
