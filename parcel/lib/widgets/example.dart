import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';

class Example extends StatelessWidget{
  final String image;
  final int number;
  const Example({super.key, required this.image, required this.number});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.grey
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5)
            ),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: Text('Example $number', style: TextStyle(
              color: AppColors.crow,
              fontWeight: FontWeight.bold
            ),),
          ),
        )
      ],
    );
  }
}