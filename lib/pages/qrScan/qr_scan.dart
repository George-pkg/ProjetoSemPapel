// libs
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
// components/widgets
import 'package:my_app/utils/colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScan extends StatefulWidget {
  const QrScan({super.key});

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: ColorsPage.green,
                borderRadius: 10,
                borderLength: 20,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            Positioned(bottom: 60, child: qrResult()),
            Positioned(top: 50, child: controlButtons()),
          ],
        ),
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((barcode) => setState(() {
          this.barcode = barcode;
          controller.pauseCamera();
        }));
  }

  Widget qrResult() => Container(
      padding: const EdgeInsets.all(12),
      child: ElevatedButton(
        onPressed: () {
          String? scannedURL = barcode?.code;

          if (scannedURL != null && isURL(scannedURL)) {
            launchUrl(Uri.parse(scannedURL));
          } else if (scannedURL != null) {
            Get.toNamed(scannedURL.toString());
          } else {}
        },
        child: Text(
          (barcode != null)
              ? (barcode!.code!.startsWith('http') || barcode!.code!.startsWith('https')
                  ? 'Abrir arquivo'
                  : 'Abrir box')
              : 'Aguarde ler o QrCode',
        ),
      ));

  // Função para verificar se é uma URL válida
  bool isURL(String url) {
    Uri uri = Uri.parse(url);
    return uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Widget controlButtons() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white24),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                icon: FutureBuilder<bool?>(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white);
                    } else {
                      return Container();
                    }
                  },
                ),
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                }),
            IconButton(
                icon: FutureBuilder(
                  future: controller?.getCameraInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return const Icon(Icons.switch_camera, color: Colors.white);
                    } else {
                      return Container();
                    }
                  },
                ),
                onPressed: () async {
                  await controller?.flipCamera();
                  setState(() {});
                }),
          ],
        ),
      );
}
