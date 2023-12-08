import 'package:flutter/material.dart';
import 'package:master/utils/colors.dart';

class AppTheme {
  static ThemeData getAppTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.green,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorsPage.green,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsPage.green),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
    );
  }
}
