import 'package:flutter/material.dart';

class AppTheme {
  static const green = Color(0xFF168A45);
  static const darkGreen = Color(0xFF0B4D2A);
  static const cream = Color(0xFFF7FFF9);

  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: green, primary: green, secondary: Colors.white),
        scaffoldBackgroundColor: cream,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: false, backgroundColor: green, foregroundColor: Colors.white),
        cardTheme: CardThemeData(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))),
      );

  static ThemeData get dark => ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: green, brightness: Brightness.dark),
        appBarTheme: const AppBarTheme(backgroundColor: darkGreen, foregroundColor: Colors.white),
      );
}
