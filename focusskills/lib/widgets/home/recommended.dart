import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';

class HomeRecommended extends StatelessWidget{
  final String title;
  final Color color;
  final String image;
  final VoidCallback onTap;

  const HomeRecommended({super.key, required this.title, required this.color, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color
            ),
            width: MediaQuery.sizeOf(context).width * 0.4,
            // height: 150,
            child: SvgPicture.asset(image),
          ),
          SizedBox(height: 10,),
          Text(title, style: TextStyle(
            color: AppColors.color,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),),
          Text('MEDITATION · 3-10 MIN', style: TextStyle(
            color: AppColors.color.withAlpha(140),
            fontSize: 12,
            fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}