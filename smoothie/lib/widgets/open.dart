import 'package:flutter/material.dart';
import 'package:smoothie/constants/colors.dart';

class OpenCard extends StatelessWidget{
  final int step;
  final String name;
  final String? subtext;
  final List<String> options;
  final Function(String) onTap;

  const OpenCard({super.key, required this.step, required this.name, this.subtext, required this.options, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Card(
        color: AppColors.white,
        elevation: 5,
        shadowColor: AppColors.orange,
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
                fontWeight: FontWeight.bold,
                fontSize: 40
              ),),
              Column(
                children: List.generate(options.length, (index) => OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  side: BorderSide(
                    color: AppColors.orange,
                    width: 2
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15)
                ),
                onPressed: () => onTap(options[index]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(options[index], style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
              ),)
              )
            ],
          ),
        ),
      ),
    );
  }
}