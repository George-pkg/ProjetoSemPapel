import 'package:flutter/material.dart';

class OilShipTest extends StatefulWidget {
  const OilShipTest({super.key});

  @override
  State<OilShipTest> createState() => _OilShipTestState();
}

class _OilShipTestState extends State<OilShipTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
