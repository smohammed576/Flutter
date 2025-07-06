import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/models/user/user.dart';
import 'package:gym/screens/auth.dart';
import 'package:gym/screens/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox('auth');
  await Hive.openBox('theme');
  final data = Hive.box<User>('users');
  final themeData = Hive.box('theme');
  if (data.isEmpty) {
    final addBarbara = User(username: 'barbara', password: 'ga83s6');
    final addMichael = User(username: 'michael', password: '9x7zih');
    await data.add(addBarbara);
    await data.add(addMichael);
  }
  if (themeData.isEmpty) {
    await themeData.put('color', 'green');
  }
  final getAuth = Hive.box('auth').get('username');
  final returnScreen = getAuth == null ? AuthScreen() : HomeScreen();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: returnScreen,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
      ),
    ),
  );
}
