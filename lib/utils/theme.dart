import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  focusColor: HexColor("FFFFFF"),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyLarge: textStyle(textColor: HexColor("2E2E2D")),
    bodySmall: textStyle(textColor: HexColor("666766")),
    bodyMedium: textStyle(textColor: HexColor("534B4A")),
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.indigo,
  focusColor: HexColor("FFFFFF"),
  scaffoldBackgroundColor: HexColor("2E2E2D"),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyLarge: textStyle(textColor: HexColor("FFFFFF")),
    bodySmall: textStyle(textColor: HexColor("EBEBEB")),
    bodyMedium: textStyle(textColor: HexColor("534B4A")),
  ),
);
