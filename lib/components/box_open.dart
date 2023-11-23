// libs
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// models/utils
import 'package:sem_papel/utils/colors.dart';

class BoxOpen extends StatelessWidget {
  final Color color;
  final String label;
  final double height;
  final double width;
  final String route;
  final String descricao;

  const BoxOpen({
    super.key,
    required this.label,
    required this.color,
    this.height = 200,
    this.width = 230,
    required this.route,
    this.descricao = 'Descrição',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      height: height,
      width: width,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(label,
            style: const TextStyle(
              fontFamily: "Goldplay-black",
              fontSize: 25,
              color: ColorsPage.blueDark,
            )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(descricao),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ElevatedButton(
              style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(150, 40))),
              onPressed: () {
                Get.toNamed(route);
              },
              child: const Text('Abrir Box')),
        )
      ]),
    );
  }
}
