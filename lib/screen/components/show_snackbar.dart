// libs
import 'package:flutter/material.dart';
// models/utils
import 'package:master/utils/colors.dart';

showSnackBar({
  required BuildContext context,
  required String label,
  bool isErro = true,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(label),
    backgroundColor: isErro ? ColorsPage.red : ColorsPage.green,
    duration: const Duration(seconds: 6),
    shape:
        const BeveledRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
    showCloseIcon: true,
  );

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
