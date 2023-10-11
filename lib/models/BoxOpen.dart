import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxOpen extends StatelessWidget {
  final String title;
  final String img;
  final String get;

  BoxOpen(this.title, this.img, this.get);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 203, 208, 228),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      height: 300,
      width: 300,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$title', style: TextStyle(fontSize: 20)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(height: 150, child: Image.asset('$img')),
          ),
          TextButton(
              onPressed: () => Get.toNamed('$get'),
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              child: const Text('OPEN', style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }
}
