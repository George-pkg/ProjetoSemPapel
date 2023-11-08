import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/appBarDynamic.dart';
import 'package:my_app/utils/colors.dart';

class Boxes extends StatefulWidget {
  const Boxes({super.key});

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: appBarDaynamic(context),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/psp-logo.svg',
                  width: 300,
                  color: ColorsPage.gray,
                ),
                const SizedBox(height: 30),
                const Text('123'),
                const SizedBox(height: 30),
                Image.asset('assets/images/quCode.png'),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple[300],
                  ),
                  height: 100,
                  width: 500,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Arraste arquivo(s) ou clique aqui para enviar'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
