import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';

class LeadingButton extends StatelessWidget{
  final bool isClose;
  final bool hasOutline;
  final VoidCallback onTap;
  const LeadingButton({super.key, required this.isClose, required this.hasOutline, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: hasOutline ? AppColors.lightcolor : null,
        shape: CircleBorder(
          side: BorderSide(width: 0.1, color: AppColors.color),
        )
      ),
      onPressed: onTap,
      icon: Icon(isClose ? Icons.close : Icons.arrow_back, color: AppColors.color, size: 24,),
    );
  }
}