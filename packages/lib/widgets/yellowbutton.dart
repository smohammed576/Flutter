import 'package:flutter/material.dart';
import 'package:packages/constants/colors.dart';

class YellowButton extends StatelessWidget{
  final String text;
  final VoidCallback onTap;

  const YellowButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.4,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellow,
          shape: RoundedRectangleBorder(),
          padding: EdgeInsets.zero
        ),
        onPressed: onTap,
        child: Text(text, style: TextStyle(
          color: AppColors.background,
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),),
      ),
    );
  }
}