import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel/constants/colors.dart';
import 'package:hotel/models/room.dart';
import 'package:hotel/providers/api.dart';
import 'package:hotel/widgets/sliderthumb.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<Room> room;
  late Room data;
  ApiService apiService = ApiService();
  int musicIndex = 0;
  int colorIndex = 6;
  double climate = 20;

  @override
  void initState() {
    super.initState();
    room = apiService.getRoom();
  }

  @override
  Widget build(BuildContext context) {
    List<String> music = ['off', 'hiphop', 'jazz', 'disco'];
    List<String> color = [
      'green',
      'blue',
      'red',
      'purple',
      'pink',
      'gold',
      'yellow',
    ];
    return Scaffold(
      body: FutureBuilder<Room>(
        future: room,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          AppColors.appColors[snapshot.data!.color] ??
                          Colors.red,
                      width: 10,
                    ),
                  ),
                  child: Image.asset(
                    'assets/curtains_${snapshot.data!.curtains}.jpg',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  room = apiService.changeSettings(
                                    'locked',
                                    snapshot.data!.locked == 0 ? 1 : 0,
                                  );
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: snapshot.data!.locked == 0
                                          ? AppColors.lightColors[snapshot
                                                .data!
                                                .color]
                                          : Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Room door',
                                          style: GoogleFonts.mukta(
                                            color: snapshot.data!.locked == 0
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          'assets/door_${snapshot.data!.locked == 0 ? 'unlocked' : 'locked'}.svg',
                                          colorFilter: ColorFilter.mode(
                                            snapshot.data!.locked == 0
                                                ? AppColors
                                                          .accentColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey
                                                : AppColors.appColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.locked == 0
                                              ? 'UNLOCKED'
                                              : 'LOCKED',
                                          style: GoogleFonts.mukta(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            color: snapshot.data!.locked == 0
                                                ? AppColors
                                                      .accentColors[snapshot
                                                      .data!
                                                      .color]
                                                : AppColors.appColors[snapshot
                                                      .data!
                                                      .color],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  room = apiService.changeSettings(
                                    'do_not_disturb',
                                    snapshot.data!.disturb == 0 ? 1 : 0,
                                  );
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: snapshot.data!.disturb == 0
                                          ? AppColors.lightColors[snapshot
                                                .data!
                                                .color]
                                          : Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Do not disturb',
                                          style: GoogleFonts.mukta(
                                            color: snapshot.data!.disturb == 0
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          'assets/do_not_disturb_${snapshot.data!.disturb == 0 ? 'off' : 'on'}.svg',
                                          colorFilter: ColorFilter.mode(
                                            snapshot.data!.disturb == 0
                                                ? AppColors
                                                          .accentColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey
                                                : AppColors.appColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.disturb == 0
                                              ? 'OFF'
                                              : 'ON',
                                          style: GoogleFonts.mukta(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            color: snapshot.data!.disturb == 0
                                                ? AppColors
                                                      .accentColors[snapshot
                                                      .data!
                                                      .color]
                                                : AppColors.appColors[snapshot
                                                      .data!
                                                      .color],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  room = apiService.changeSettings(
                                    'make_up_room',
                                    snapshot.data!.makeup == 0 ? 1 : 0,
                                  );
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: snapshot.data!.makeup == 0
                                          ? AppColors.lightColors[snapshot
                                                .data!
                                                .color]
                                          : Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Make up room',
                                          style: GoogleFonts.mukta(
                                            color: snapshot.data!.makeup == 0
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          'assets/make_up_room_${snapshot.data!.makeup == 0 ? 'off' : 'on'}.svg',
                                          colorFilter: ColorFilter.mode(
                                            snapshot.data!.makeup == 0
                                                ? AppColors
                                                          .accentColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey
                                                : AppColors.appColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.makeup == 0
                                              ? 'OFF'
                                              : 'ON',
                                          style: GoogleFonts.mukta(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            color: snapshot.data!.makeup == 0
                                                ? AppColors
                                                      .accentColors[snapshot
                                                      .data!
                                                      .color]
                                                : AppColors.appColors[snapshot
                                                      .data!
                                                      .color],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Room',
                                  style: GoogleFonts.mukta(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data!.number}',
                                  style: GoogleFonts.mukta(
                                    fontSize: 70,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),
                                child: Container(
                                  width: 370,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: AppColors
                                        .lightColors[snapshot.data!.color],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        SliderTheme(
                                          data: SliderThemeData(
                                            overlayColor: AppColors.accentColors[snapshot.data!.color],
                                            trackHeight: 10,
                                            activeTrackColor: const Color(
                                              0xA1EAEAEA,
                                            ),
                                            inactiveTrackColor: const Color(
                                              0xA1EAEAEA,
                                            ),
                                            thumbColor:
                                                AppColors.thumbColors[snapshot
                                                    .data!
                                                    .color],
                                            thumbShape: SliderThumb(
                                              thumbRadius: 25,
                                            ),
                                          ),
                                          child: Slider(
                                            min: 16,
                                            max: 26,
                                            value: climate,
                                            onChanged: (value) {
                                              setState(() {
                                                climate = value.roundToDouble();
                                              });
                                            },
                                            onChangeEnd: (value) {
                                              setState(() {
                                                room = apiService
                                                    .changeSettings(
                                                      'climate',
                                                      climate,
                                                    );
                                              });
                                            },
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                color:
                                                    AppColors
                                                        .accentColors[snapshot
                                                        .data!
                                                        .color],
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
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  room = apiService.changeSettings(
                                    'curtains',
                                    snapshot.data!.curtains == 'open'
                                        ? 'closed'
                                        : 'open',
                                  );
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: snapshot.data!.curtains == 'open'
                                          ? AppColors.lightColors[snapshot
                                                .data!
                                                .color]
                                          : Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Curtains',
                                          style: GoogleFonts.mukta(
                                            color:
                                                snapshot.data!.curtains ==
                                                    'open'
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          'assets/curtains_${snapshot.data!.curtains}.svg',
                                          colorFilter: ColorFilter.mode(
                                            snapshot.data!.curtains == 'open'
                                                ? AppColors
                                                          .accentColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey
                                                : AppColors.appColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.curtains.toUpperCase(),
                                          style: GoogleFonts.mukta(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            color:
                                                snapshot.data!.curtains ==
                                                    'open'
                                                ? AppColors
                                                      .accentColors[snapshot
                                                      .data!
                                                      .color]
                                                : AppColors.appColors[snapshot
                                                      .data!
                                                      .color],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (musicIndex >= 3) {
                                    musicIndex = 0;
                                  } else {
                                    musicIndex++;
                                  }
                                  room = apiService.changeSettings(
                                    'music',
                                    music[musicIndex],
                                  );
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: snapshot.data!.music == 'off'
                                          ? AppColors.lightColors[snapshot
                                                .data!
                                                .color]
                                          : Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Music',
                                          style: GoogleFonts.mukta(
                                            color: snapshot.data!.music == 'off'
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          'assets/music_${snapshot.data!.music != 'off' ? 'on' : snapshot.data!.music}.svg',
                                          colorFilter: ColorFilter.mode(
                                            snapshot.data!.music == 'off'
                                                ? AppColors
                                                          .accentColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey
                                                : AppColors.appColors[snapshot
                                                          .data!
                                                          .color] ??
                                                      Colors.grey,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.music.toUpperCase(),
                                          style: GoogleFonts.mukta(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            color: snapshot.data!.music == 'off'
                                                ? AppColors
                                                      .accentColors[snapshot
                                                      .data!
                                                      .color]
                                                : AppColors.appColors[snapshot
                                                      .data!
                                                      .color],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (colorIndex >= 6) {
                                    colorIndex = 0;
                                  } else {
                                    colorIndex++;
                                  }
                                  room = apiService.changeSettings(
                                    'room_colour',
                                    color[colorIndex],
                                  );
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: AppColors
                                          .lightColors[snapshot.data!.color],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Room color',
                                          style: GoogleFonts.mukta(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            color:
                                                AppColors.appColors[snapshot
                                                    .data!
                                                    .color],
                                            border: Border.all(
                                              color:
                                                  AppColors
                                                      .accentColors[snapshot
                                                      .data!
                                                      .color] ??
                                                  Colors.grey,
                                              width: 6,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.color.toUpperCase(),
                                          style: GoogleFonts.mukta(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            color:
                                                AppColors.accentColors[snapshot
                                                    .data!
                                                    .color],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Text('no data');
        },
      ),
    );
  }
}
