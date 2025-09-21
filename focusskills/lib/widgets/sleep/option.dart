import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';

class SleepOption extends StatelessWidget{
  final String title;
  final String image;
  final VoidCallback onTap;

  const SleepOption({super.key, required this.title, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.42,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SvgPicture.asset(image, width: MediaQuery.sizeOf(context).width * 0.42),
            ),
            SizedBox(height: 10,),
            Text(title, style: TextStyle(
              color: AppColors.lightcolor,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),),
            SizedBox(height: 5,),
            Text('45 MIN · SLEEP MUSIC', style: TextStyle(
              color: AppColors.lightcolor.withAlpha(150),
              fontWeight: FontWeight.w600,
              fontSize: 12
            ),)
          ],
        ),
      ),
    );
  }
}