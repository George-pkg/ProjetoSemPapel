import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/models/appBarDynamic.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDynamic(),
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    color: Colors.green,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.blueGrey,
                  ),
                  Text(Get.currentRoute)
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.blueGrey,
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    color: Colors.green,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
