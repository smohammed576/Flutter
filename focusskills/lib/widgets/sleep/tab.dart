import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';

class SleepTab extends StatelessWidget{
  final String label;
  final String icon;
  final Color background;
  final Color color;
  const SleepTab({super.key, required this.label, required this.icon, required this.background, required this.color});

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(16),
        child: SvgPicture.asset(icon, colorFilter: ColorFilter.mode(AppColors.lightcolor, BlendMode.srcIn), width: 20,)
      ),
      iconMargin: EdgeInsets.only(bottom: 2),
      child: Text(label, style: TextStyle(
        color: color,
        fontSize: 12
      ),),
    );
  }
}