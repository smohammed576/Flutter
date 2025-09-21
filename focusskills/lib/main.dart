import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/routes/navigator.dart';
import 'package:focusskills/screens/auth/auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox('auth');
  await Hive.openBox('newuser');
  await Hive.openBox('music');
  final users = Hive.box<User>('users');
  final auth = Hive.box('auth').get('id');
  final returnScreen = auth != null ? MainNavigator(user: users.values.firstWhere((item) => item.id == auth)) : AuthScreen();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppColors.white
      ),
      home: returnScreen,
    )
  );
}