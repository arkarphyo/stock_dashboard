import 'package:flutter/material.dart';

import 'AppConstant.dart';

/// all custom application theme
class AppTheme {
  /// default application theme
  static ThemeData get basic => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        fontFamily: Font.poppins,
        primaryColorDark: const Color.fromARGB(255, 53, 152, 177),
        primaryColor: const Color.fromARGB(255, 61, 124, 143),
        primaryColorLight: const Color.fromARGB(255, 84, 218, 252),
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue,
        hintColor: Colors.black.withOpacity(0.5),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 34, 32, 48),
        ).merge(
          ButtonStyle(elevation: MaterialStateProperty.all(0)),
        )),
        canvasColor: const Color.fromRGBO(31, 29, 44, 1),
        cardColor: const Color.fromRGBO(38, 40, 55, 1),
      );

  // you can add other custom theme in this class like  light theme, dark theme ,etc.

  // example :
  static ThemeData get light => ThemeData();

  static ThemeData get dark => ThemeData();
}
