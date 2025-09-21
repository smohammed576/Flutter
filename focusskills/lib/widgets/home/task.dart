import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';

class HomeTask extends StatelessWidget{
  final String name;
  final String type;
  final List<Color> colors;
  final String image;
  final bool isLight;
  final VoidCallback onTap;

  const HomeTask({super.key, required this.name, required this.type, required this.colors, required this.image, required this.isLight, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(10)
      ),
      width: MediaQuery.sizeOf(context).width * 0.42,
      height: 190,
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(image, height: 80,),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(
                        color: colors[1],
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),),
                      Text(type, style: TextStyle(
                        color: colors[1],
                        fontSize: 12
                      ),),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('3-10 MIN', style: TextStyle(
                          color: isLight ? AppColors.lightcolor : AppColors.color,
                          fontSize: 12
                        ),),
                        SizedBox(
                          width: 70,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isLight ? AppColors.lightcolor : AppColors.color,
                              padding: EdgeInsets.zero,
                              elevation: 0
                            ),
                            onPressed: onTap,
                            child: Text('START', style: TextStyle(
                              color: isLight ? AppColors.color : AppColors.lightcolor,
                              fontSize: 12
                            ),),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}