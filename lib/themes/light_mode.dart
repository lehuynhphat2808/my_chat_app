import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade600,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
  appBarTheme: AppBarTheme(
      color: Colors.grey.shade500,
      foregroundColor: Colors.white,
      centerTitle: true),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey.shade300,
  ),
  textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.grey.shade500),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
);
