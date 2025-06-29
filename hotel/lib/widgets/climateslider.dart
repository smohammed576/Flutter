import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel/constants/colors.dart';
import 'package:hotel/models/room.dart';
import 'package:hotel/widgets/sliderthumb.dart';

class ClimateSlider extends StatelessWidget {
  final Room room;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;
  final double climate;

  const ClimateSlider({
    super.key,
    required this.room,
    required this.onChanged,
    required this.onChangeEnd,
    required this.climate
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 370,
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.lightColors[room.color],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    overlayColor: AppColors.accentColors[room.color],
                    trackHeight: 10,
                    activeTrackColor: const Color(0xA1EAEAEA),
                    inactiveTrackColor: const Color(0xA1EAEAEA),
                    thumbColor: AppColors.thumbColors[room.color],
                    thumbShape: SliderThumb(thumbRadius: 25),
                  ),
                  child: Slider(
                    min: 16,
                    max: 26,
                    value: climate,
                    onChanged: onChanged,
                    onChangeEnd: onChangeEnd
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Temperature',
                      style: GoogleFonts.mukta(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$climate DEGREES',
                      style: GoogleFonts.mukta(
                        color: AppColors.accentColors[room.color],
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
