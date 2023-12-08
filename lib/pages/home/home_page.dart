// libs
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// components/widgets
import 'package:master/components/appbar_dynamic.dart';
import 'package:master/components/backgroud/backgroud.dart';
import 'package:master/components/box_open.dart';
// models/utils
import 'package:master/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isDesktop = constraints.maxWidth > 700;
      return Container(
        color: ColorsPage.blueAccent,
        child: Stack(
          children: [
            isDesktop ? deskotBackgroud() : mobileBackgroud(),
            Scaffold(
              appBar: appBarDaynamic(context),
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                      color: Colors.white70,
                      width: isDesktop ? Get.width * 0.7 : Get.width * 0.95,
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: isDesktop ? _buildDesktopBody() : _buildMobileBody()),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildMobileBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: SvgPicture.asset('assets/images/psp-logo.svg',
              width: 300, colorFilter: const ColorFilter.mode(ColorsPage.gray, BlendMode.srcATop)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.5),
          child: BoxOpen(
            label: 'Box1',
            color: Color.fromRGBO(207, 216, 220, 1),
            route: '/Boxes/6544fd0dffaa140032d59a72',
            descricao: 'Modificado há 1 dia',
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.5),
          child: BoxOpen(
            label: 'Box2',
            color: Color.fromRGBO(207, 216, 220, 1),
            route: '/Boxes/654e6daeffaa140032d59ac5',
            descricao: 'Modificado há 5 horas',
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.5),
          child: BoxOpen(
            label: 'Box3',
            color: Color.fromRGBO(207, 216, 220, 1),
            route: '/Boxes/6557c2d0ffaa140032d59b6e',
            descricao: 'Em análise',
          ),
        )
      ],
    );
  }

  Widget _buildDesktopBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: SvgPicture.asset('assets/images/psp-logo.svg',
              width: 300, colorFilter: const ColorFilter.mode(ColorsPage.gray, BlendMode.srcATop)),
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
    );
  }
}
