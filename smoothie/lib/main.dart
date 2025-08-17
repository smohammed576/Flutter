import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smoothie/models/smoothie/smoothie.dart';
import 'package:smoothie/screens/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SmoothieAdapter());
  await Hive.openBox<Smoothie>('smoothies');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit'
      ),
      home: HomeScreen(),
    )
  );
}