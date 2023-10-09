import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
                onPressed: () => Get.toNamed('/HomePage'),
                child: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                )),
            TextButton(
              style: const ButtonStyle(),
              onPressed: () {
                Get.toNamed('/HomePage/API');
              },
              child: const Text(
                'API',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              style: const ButtonStyle(),
              onPressed: () {
                Get.toNamed('');
              },
              child: const Text(
                'Documents',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239));
  }
}
