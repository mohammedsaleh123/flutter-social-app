import 'package:flutter/material.dart';
import 'package:socialapp/core/app_colors.dart';

class AppTheme {
  ThemeData myDarkTheme() {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: darkC),
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkC,
      appBarTheme: const AppBarTheme(
        backgroundColor: offLightC,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: offLightC,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkC,
      ),
    );
  }

  ThemeData myLightTheme() {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: lightC),
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightC,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryC,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryC,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: lightC,
      ),
    );
  }
}
