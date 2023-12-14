import 'package:flutter/material.dart';

final mainTheme = ThemeData(
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
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.black),
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
  ),
);
