import 'package:flutter/material.dart';
import 'package:packages/constants/colors.dart';
import 'package:packages/providers/session.dart';
import 'package:packages/screens/home.dart';
import 'package:packages/screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background
      ),
      home: FutureBuilder(
        future: SessionService().isLoggedIn(), 
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Scaffold(
              body: Center(
                child: Text('no data', style: TextStyle(
                  color: AppColors.color
                ),),
              ),
            );
          } else {
            return snapshot.data! ? HomeScreen() : RegisterScreen();
          }
        },
      )
    )
  );
}