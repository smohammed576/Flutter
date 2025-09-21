import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';

class HomeDaily extends StatelessWidget{
  final String title;
  final String subtitle;
  final bool isLight;
  final VoidCallback onTap;
  const HomeDaily({super.key, required this.title, required this.subtitle, required this.isLight, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: isLight ? AppColors.nearblack : AppColors.meditateCow,
              child: SvgPicture.asset('assets/backgrounds/${isLight ? 'cow_background' : 'cow_background_orange'}.svg')),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(
                      color: isLight ? AppColors.white : AppColors.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 5,),
                    Text(subtitle, style: TextStyle(
                      color: isLight ? AppColors.lightcolor : AppColors.color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
                SizedBox(
                  width: 50,
                  height: 70,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero
                    ),
                    onPressed: onTap,
                    icon: SvgPicture.asset('assets/icons/play_${isLight ? 'light' : 'dark'}.svg'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}