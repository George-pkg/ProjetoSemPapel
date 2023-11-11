import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
InputDecoration DecorationInput(
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
  );
}
