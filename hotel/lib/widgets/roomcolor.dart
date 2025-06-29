import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel/constants/colors.dart';
import 'package:hotel/models/room.dart';

class RoomColor extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;

  const RoomColor({super.key, required this.room, required this.onTap});

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
              color: AppColors.lightColors[room.color],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Room color',
                  style: GoogleFonts.mukta(color: Colors.white, fontSize: 18),
                ),
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: AppColors.appColors[room.color],
                    border: Border.all(
                      color:
                          AppColors.accentColors[room.color] ??
                          Colors.grey,
                      width: 6,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                Text(
                  room.color.toUpperCase(),
                  style: GoogleFonts.mukta(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: AppColors.accentColors[room.color],
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
