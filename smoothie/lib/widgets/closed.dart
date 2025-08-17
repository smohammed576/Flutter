import 'package:flutter/material.dart';
import 'package:smoothie/constants/colors.dart';

class ClosedCard extends StatelessWidget{
  final int step;
  final String name;
  final String? chosen;
  final VoidCallback onTap;
  const ClosedCard({super.key, required this.step, required this.name, this.chosen, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 350,
        child: Card(
          color: AppColors.white,
          elevation: 5,
          shadowColor: AppColors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Step $step', style: TextStyle(
                  color: AppColors.color,
                  fontSize: 20
                ),),
                Text(name, style: TextStyle(
                  color: AppColors.color,
                  fontWeight: FontWeight.w600,
                  fontSize: 40
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}