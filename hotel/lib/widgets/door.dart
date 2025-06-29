import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel/constants/colors.dart';
import 'package:hotel/models/room.dart';

class Door extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;

  const Door({super.key, required this.room, required this.onTap});

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
              color: room.locked == 0
                  ? AppColors.lightColors[room.color]
                  : Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Room door',
                  style: GoogleFonts.mukta(
                    color: room.locked == 0
                        ? Colors.white
                        : Colors.black,
                    fontSize: 18,
                  ),
                ),
                SvgPicture.asset(
                  'assets/door_${room.locked == 0 ? 'unlocked' : 'locked'}.svg',
                  colorFilter: ColorFilter.mode(
                    room.locked == 0
                        ? AppColors.accentColors[room.color] ??
                              Colors.grey
                        : AppColors.appColors[room.color] ??
                              Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  room.locked == 0 ? 'UNLOCKED' : 'LOCKED',
                  style: GoogleFonts.mukta(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: room.locked == 0
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
