import 'package:flutter/material.dart';

ThemeData mesaTheme = ThemeData(
  fontFamily: 'Montserrat',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      primary: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Constants.orange),
      primary: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: Constants.enableBorder,
        width: 1.0,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: Constants.focusedBorder,
        width: 1.25,
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: Constants.primaryColor300,
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: Constants.primaryColor300,
        width: 1.0,
      ),
    ),
  ),
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

class Constants {

  //colors palette
  static const Color primaryColor100 = Color(0xffFFFFFF);
  static const Color primaryColor200 = Color(0xff74B49E);
  static const Color primaryColor300 = Color(0xffFDA57D);

  // Text color
  static const Color primaryColor = Color(0xffF5F5F5);
  static const Color inactiveText = Color(0xff707882);
  static const Color activeText = Color(0xff424649);

  // Input line border
  static const Color enableBorder = Color(0xff424649);
  static const Color focusedBorder = Color(0xff707882);

  // colors
  static const Color lightGrey = Color(0xffF5F5F5);
  static const Color lightest = Color(0xffFFFFFF);
  static const Color green = Color(0xff28B3BB);
  static const Color yellow = Color(0xffF9D620);
  static const Color darkBlue = Color(0xff364F6B);
  static const Color orange = Color(0xffEB8B76);
  static const Color lightAndClear = Color(0xffF5F5F5);

}

