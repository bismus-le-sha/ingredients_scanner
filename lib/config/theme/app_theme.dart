import 'package:flutter/material.dart';

const primaryColor = Colors.black;
const secondaryColor = Color(0xFF6D8B6E);

final appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: secondaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: secondaryColor,
    colorScheme: const ColorScheme.light(
      primary: secondaryColor,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: secondaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: primaryColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle:
          const TextStyle(color: secondaryColor, fontSize: 18.0),
      iconColor: primaryColor,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: secondaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ));
