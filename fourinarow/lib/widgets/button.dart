import 'package:flutter/material.dart';
import 'package:fourinarow/constants/colors.dart';

class WhiteButton extends StatelessWidget{
  final String text;
  final VoidCallback onTap;

  const WhiteButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          )
        ),
        onPressed: onTap,
        child: Text(text, style: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22
        ),),
      ),
    );
  }
}