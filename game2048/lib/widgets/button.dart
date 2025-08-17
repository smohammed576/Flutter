import 'package:flutter/material.dart';
import 'package:game2048/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlineButton extends StatelessWidget{
  final String text;
  final double fontsize;
  final VoidCallback onTap;

  const OutlineButton({super.key, required this.text, required this.fontsize, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: BeveledRectangleBorder()
      ),
      onPressed: onTap,
      child: Text('New Game', style: GoogleFonts.shadowsIntoLightTwo(
        color: AppColors.color,
        fontSize: fontsize
      ),),
    );
  }
}