import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';

class LogoutButton extends StatelessWidget{
  final VoidCallback onTap;
  const LogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          padding: EdgeInsets.zero,
          elevation: 0
        ),
        onPressed: onTap,
        child: Text('SIGN OUT', style: TextStyle(
          color: AppColors.lightcolor,
          fontSize: 12
        ),),
      ),
    );
  }
}