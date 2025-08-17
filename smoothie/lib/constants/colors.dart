import 'package:flutter/material.dart';

class AppColors{
  static const LinearGradient background = LinearGradient(
    colors: [
      Color(0xffFFEEE4),
      Color(0xffffc7a2)
    ]
  );
  static const LinearGradient reversed = LinearGradient(
    colors: [
      Color(0xffffc7a2),
      Color(0xffFFEEE4)
    ]
  );
  static const Color color = Color(0xFF6C3D51);
  static const Color orange = Color(0xFFFC8A41);
  static const Color purple = Color(0xffAA5498);
  static const Color white = Colors.white;
  static const Color green = Color(0xff06B853);

  static const Map<String, Color> drinkColors = {
    'melk': Colors.white,
    'water': Colors.lightBlue,
    'yoghurt': Colors.white,
    'havermelk': Color.fromARGB(255, 244, 241, 215),

    'aardbei': Colors.red,
    'banaan': Colors.yellow,
    'mango': Color.fromARGB(255, 241, 195, 126),
    'blauwebes': Color.fromARGB(255, 86, 33, 243),
    'avocado': Colors.greenAccent,

    'proteinepoeder': Color.fromARGB(255, 193, 150, 134),
    'chiazaad': Colors.brown,
    'honing': Color.fromARGB(255, 232, 181, 31),
    'spinazie': Color.fromARGB(255, 13, 123, 17)
  };
}