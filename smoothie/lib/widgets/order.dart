import 'package:flutter/material.dart';
import 'package:smoothie/constants/colors.dart';

class ShopOrder extends StatelessWidget{
  final String name;
  final VoidCallback onTap;
  const ShopOrder({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white
      ),
      margin: EdgeInsets.only(bottom: 10),
      width: 500,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Smoothie', style: TextStyle(
                color: AppColors.color,
                fontSize: 35,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 10,),
              Text(name, style: TextStyle(
                color: AppColors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),)
            ],
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(Icons.restore_from_trash, color: AppColors.orange, size: 50,),
          )
        ],
      ),
    );
  }
}