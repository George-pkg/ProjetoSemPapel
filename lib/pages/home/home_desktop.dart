// libs
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// components/widgets
import 'package:my_app/components/appbar_dynamic.dart';
import 'package:my_app/components/box_open.dart';
// models/utils
import 'package:my_app/utils/colors.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsPage.whiteSmoke,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Transform.scale(
                scale: 2,
                child: SvgPicture.asset(
                  'assets/images/psp-background.svg',
                  fit: BoxFit.fill,
                  colorFilter: const ColorFilter.mode(ColorsPage.green, BlendMode.srcIn),
                  alignment: AlignmentDirectional.bottomCenter,
                  
                ),
              ),
            ),
          ),
          Scaffold(
            appBar: appBarDaynamic(context),
            backgroundColor: Colors.transparent,
            body: _body(),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white70,
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SvgPicture.asset('assets/images/psp-logo.svg',
                    width: 300,
                    colorFilter: const ColorFilter.mode(ColorsPage.gray, BlendMode.srcATop)),
              ),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                BoxOpen(
                  label: 'Box1',
                  color: Color.fromRGBO(207, 216, 220, 1),
                  route: '/Boxes/6544fd0dffaa140032d59a72',
                  descricao: 'Modificado há 1 dia',
                ),
                BoxOpen(
                  label: 'Box2',
                  color: Color.fromRGBO(207, 216, 220, 1),
                  route: '/Boxes/654e6daeffaa140032d59ac5',
                  descricao: 'Modificado há 5 horas',
                )
              ]),
              const SizedBox(height: 40),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                BoxOpen(
                  label: 'Box3',
                  color: Color.fromRGBO(207, 216, 220, 1),
                  route: '/Boxes/6557c2d0ffaa140032d59b6e',
                  descricao: 'Em análise',
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
