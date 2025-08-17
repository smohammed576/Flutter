import 'package:flutter/material.dart';

class FloatingLogo extends StatelessWidget{
  const FloatingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50),
      child: Image.asset('assets/BlenderBende_logo.png', width: 320,),
    );
  }
}