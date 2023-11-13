// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_app/utils/colors.dart';

ShowSnackBar({
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
