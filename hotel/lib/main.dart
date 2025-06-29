import 'package:flutter/material.dart';
import 'package:hotel/screens/dashboard.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: DashboardScreen(),
    )
  );
}