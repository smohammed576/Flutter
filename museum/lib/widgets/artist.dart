import 'package:flutter/material.dart';
import 'package:museum/constants/colors.dart';

class ArtistCard extends StatelessWidget{
  final String name;
  final String image;
  final List<int> dates;
  final String direction;

  const ArtistCard({super.key, required this.name, required this.image, required this.dates, required this.direction});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: direction == 'start' ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  if(direction == 'start')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover,),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: direction == 'start' ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    children: [
                      Text(name, style: TextStyle(
                        fontSize: 22,
                        color: AppColors.background,
                        fontWeight: FontWeight.w500
                      ),),
                      Text('${dates[0]} - ${dates[1]}', style: TextStyle(
                        color: AppColors.greycolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                  SizedBox(width: 10,),
                  if(direction == 'end')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover,),
                  ),
                ],
              ),
            );
  }

}