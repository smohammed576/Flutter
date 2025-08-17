import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game2048/constants/colors.dart';
import 'package:game2048/screens/home.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
      ),
    )
  );
}

//12:54