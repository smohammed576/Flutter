import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';

class GreenButton extends StatelessWidget{
  final String text;
  final IconData? icon;
  final VoidCallback onTap;
  const GreenButton({super.key, required this.text, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.zero
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon != null)
            Icon(icon!, color: AppColors.white, size: 25,),
            SizedBox(width: icon != null ? 10 : null),
            Text(text, style: TextStyle(
              color: AppColors.white,
              fontSize: 15
            ),),
          ],
        ),
      ),
    );
  }
}