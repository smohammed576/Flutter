import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel/constants/colors.dart';
import 'package:hotel/models/room.dart';

class Curtains extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;

  const Curtains({super.key, required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: room.curtains == 'open'
                  ? AppColors.lightColors[room.color]
                  : Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Curtains',
                  style: GoogleFonts.mukta(
                    color: room.curtains == 'open'
                        ? Colors.white
                        : Colors.black,
                    fontSize: 18,
                  ),
                ),
                SvgPicture.asset(
                  'assets/curtains_${room.curtains}.svg',
                  colorFilter: ColorFilter.mode(
                    room.curtains == 'open'
                        ? AppColors.accentColors[room.color] ??
                              Colors.grey
                        : AppColors.appColors[room.color] ??
                              Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  room.curtains.toUpperCase(),
                  style: GoogleFonts.mukta(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: room.curtains == 'open'
                        ? AppColors.accentColors[room.color]
                        : AppColors.appColors[room.color],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
