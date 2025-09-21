import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focusskills/constants/colors.dart';

class OpacityButton extends StatelessWidget{
  final String icon;
  final VoidCallback onTap;

  const OpacityButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: AppColors.black.withAlpha(100),
          shape: CircleBorder(),
          padding: EdgeInsets.zero
        ),
        onPressed: onTap,
        icon: SvgPicture.asset(icon, width: 18,),
      ),
    );
  }
}