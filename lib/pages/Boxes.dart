import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/widgets/appBarDynamic.dart';
import 'package:my_app/utils/colors.dart';

class Boxes extends StatefulWidget {
  const Boxes({super.key, String? id});

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: appBarDaynamic(context),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SvgPicture.asset(
                      'assets/images/psp-logo.svg',
                      width: 300,
                      color: ColorsPage.gray,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      '123',
                      style: TextStyle(
                          fontFamily: "Goldplay-black", fontSize: 25, color: ColorsPage.blueDark),
                    ),
                  ),
                  Image.asset('assets/images/quCode.png'),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: DottedBorder(
                      color: ColorsPage.greenDark,
                      strokeWidth: 1.1,
                      child: SizedBox(
                        height: 100,
                        width: 500,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Arraste arquivo(s) ou clique aqui para enviar',
                              style: TextStyle(color: Colors.black87)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
