import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: lightTheme,
      // darkTheme: ThemeData(scaffoldBackgroundColor: Colors.black),
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    ),
  );
}