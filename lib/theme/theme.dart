import 'package:flutter/material.dart';

final mainTheme = ThemeData(
  primaryColor: const Color(0xFF6D8B6E),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    backgroundColor: Color(0xFF6D8B6E),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 20)),
  ),
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 24,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 18.0),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(0.0),
    labelStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 14.0,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
      borderRadius: BorderRadius.circular(10.0),
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18.0,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 1.5),
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);
