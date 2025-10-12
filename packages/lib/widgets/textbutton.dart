import 'package:flutter/material.dart';
import 'package:packages/constants/colors.dart';

class BlueTextButton extends StatelessWidget{
  final String text;
  final Color? color;
  final VoidCallback onTap;

  const BlueTextButton({super.key, required this.text, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(text, style: TextStyle(
        color: color ?? AppColors.yellow
      ),),
    );
  }
}