import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';

class PurpleButton extends StatelessWidget{
  final String text;
  final bool isNotPurple;
  final VoidCallback onTap;
  const PurpleButton({super.key, required this.text, required this.isNotPurple, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isNotPurple ? AppColors.lightcolor : AppColors.purple,
          elevation: 0,
          padding: EdgeInsets.zero
        ),
        onPressed: onTap,
        child: Text(text, style: TextStyle(
          color: isNotPurple ? AppColors.color : AppColors.lightcolor,
          fontSize: 14
        ),),
      ),
    );
  }
}