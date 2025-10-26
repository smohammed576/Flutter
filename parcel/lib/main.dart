import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/providers/session.dart';
import 'package:parcel/screens/auth.dart';
import 'package:parcel/screens/home.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: 'Geist'
      ),
      home: FutureBuilder(
        future: SessionService().isLoggedIn(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Scaffold(
              body: Center(
                child: Text('no data'),
              ),
            );
          } else {
            return snapshot.data! ? HomeScreen() : AuthScreen();
          }
        }
      ),
    )
  );
}