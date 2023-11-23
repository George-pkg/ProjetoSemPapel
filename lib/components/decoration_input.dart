// libs
import 'package:flutter/material.dart';
// models/utils
import 'package:sem_papel/utils/colors.dart';

InputDecoration decorationInput(
  String label,
  Color colors,
) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(color: colors),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: colors),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: colors),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: ColorsPage.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: ColorsPage.red),
    ),
    errorStyle: const TextStyle(color: ColorsPage.red),
  );
}
