import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sem_papel/utils/colors.dart';

Widget deskotBackgroud() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      height: Get.height * 0.3,
      width: Get.width * 0.5,
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
  );
}

Widget mobileBackgroud() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: SvgPicture.asset(
      'assets/images/psp-background.svg',
      fit: BoxFit.contain,
      colorFilter: const ColorFilter.mode(ColorsPage.green, BlendMode.srcIn),
      alignment: AlignmentDirectional.bottomStart,
      width: double.infinity,
    ),
  );
}
