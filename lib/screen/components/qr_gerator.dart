// libs
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
// models/utils
import 'package:master/utils/colors.dart';

class QrGerator extends StatelessWidget {
  const QrGerator(this.route, this.size, {super.key});

  final String route;
  final double size;

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: route,
      size: size,
      backgroundColor: Colors.white,
      eyeStyle: const QrEyeStyle(color: ColorsPage.green, eyeShape: QrEyeShape.square),
      dataModuleStyle: const QrDataModuleStyle(
          color: ColorsPage.green, dataModuleShape: QrDataModuleShape.square),
      embeddedImageStyle: const QrEmbeddedImageStyle(
        size: Size(
          100,
          100,
        ),
      ),
    );
  }
}
