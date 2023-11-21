// libs
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// components/widgets
import 'package:my_app/components/appbar_dynamic.dart';
import 'package:my_app/components/box_open.dart';
// models/utils
import 'package:my_app/utils/colors.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsPage.whiteSmoke,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/images/psp-background.svg',
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(ColorsPage.green, BlendMode.srcATop),
              alignment: AlignmentDirectional.bottomStart,
              width: double.infinity,
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
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SvgPicture.asset(
                  'assets/images/psp-logo.svg',
                  width: 300,
                  colorFilter: const ColorFilter.mode(ColorsPage.gray, BlendMode.srcATop)
                ),
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
          ),
        ),
      ),
    );
  }
}
