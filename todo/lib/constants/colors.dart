import 'package:flutter/material.dart';

class AppColors{
  //lighttheme
  static const Color lightPrimary = Color(0xFFEFE9DC);
  static const Color lightSecondary = Colors.white;
  static const Color lightAccent = Color(0xFFA83535);
  static const Color lightColor = Colors.black;

  //darktheme
  static const Color darkPrimary = Colors.black;
  static const Color darkSecondary = Color(0xFF5E5E5E);
  static const Color darkAccent = Color(0xFFD44848);
  static const Color darkColor = Colors.white;
}

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightPrimary,
  primaryColor: AppColors.lightSecondary,
  brightness: Brightness.light,
  cardColor: AppColors.lightAccent

);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.darkPrimary,
  primaryColor: AppColors.darkSecondary,
  brightness: Brightness.dark,
  cardColor: AppColors.darkAccent

);