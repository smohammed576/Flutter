import 'package:flutter/material.dart';
import 'package:fourinarow/constants/colors.dart';
import 'package:fourinarow/screens/home.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Anybody'
      ),
      home: HomeScreen(),
    )
  );
}