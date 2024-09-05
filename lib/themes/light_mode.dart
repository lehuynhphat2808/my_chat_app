import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.white,
    secondary: const Color(0xffCD5D7A),
    tertiary: const Color(0xffCD5D7A).withOpacity(0.4),
    inversePrimary: const Color(0xffBB2649),
  ),
  appBarTheme: const AppBarTheme(
      color: Color(0xffCD5D7A),
      foregroundColor: Colors.white,
      centerTitle: true),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xffD26E8A),
  ),
  dividerTheme: const DividerThemeData(color: Colors.white),
  textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
);
