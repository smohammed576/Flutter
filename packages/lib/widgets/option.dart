import 'package:flutter/material.dart';
import 'package:packages/constants/colors.dart';

class LogOption extends StatelessWidget{
  final String text;
  final Icon icon;
  final VoidCallback onTap;

  const LogOption({super.key, required this.text, required this.icon, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onTap, 
          icon: icon, iconSize: 30,
        ),
        SizedBox(height: 10,),
        Text(text, style: TextStyle(
          color: AppColors.color,
          fontSize: 14
        ),)
      ],
    );
  }
}