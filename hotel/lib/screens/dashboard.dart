import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel/constants/colors.dart';
import 'package:hotel/models/room.dart';
import 'package:hotel/providers/api.dart';
import 'package:hotel/widgets/climateslider.dart';
import 'package:hotel/widgets/curtains.dart';
import 'package:hotel/widgets/dnd.dart';
import 'package:hotel/widgets/door.dart';
import 'package:hotel/widgets/makeup.dart';
import 'package:hotel/widgets/music.dart';
import 'package:hotel/widgets/roomcolor.dart';

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
    List<String> color = [ 'green', 'blue', 'red', 'purple', 'pink', 'gold', 'yellow'];
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
                      color: AppColors.appColors[snapshot.data!.color] ?? Colors.red,
                      width: 10,
                    ),
                  ),
                  child: Image.asset('assets/curtains_${snapshot.data!.curtains}.jpg', height: double.infinity, width: double.infinity, fit: BoxFit.cover),
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
                            Door(
                              room: snapshot.data!,
                              onTap: () {
                                setState(() {
                                  room = apiService.changeSettings('locked', snapshot.data!.locked == 0 ? 1 : 0);
                                });
                              },
                            ),
                            DoNotDisturb(
                              room: snapshot.data!,
                              onTap: () {
                                setState(() {
                                  room = apiService.changeSettings('do_not_disturb', snapshot.data!.disturb == 0 ? 1 : 0);
                                });
                              },
                            ),
                            MakeUp(
                              room: snapshot.data!,
                              onTap: () {
                                setState(() {
                                  room = apiService.changeSettings('make_up_room', snapshot.data!.makeup == 0 ? 1 : 0);
                                });
                              },
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
                                Text('Room', style: GoogleFonts.mukta(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text('${snapshot.data!.number}', style: GoogleFonts.mukta(
                                    fontSize: 70,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            ClimateSlider(
                              room: snapshot.data!,
                              onChanged: (value) {
                                setState(() {
                                  climate = value.roundToDouble();
                                });
                              },
                              onChangeEnd: (value) {
                                setState(() {
                                  room = apiService.changeSettings('climate', climate);
                                });
                              },
                              climate: climate,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Curtains(
                              room: snapshot.data!,
                              onTap: () {
                                setState(() {
                                  room = apiService.changeSettings('curtains', snapshot.data!.curtains == 'open' ? 'closed' : 'open');
                                });
                              },
                            ),
                            Music(
                              room: snapshot.data!,
                              onTap: () {
                                setState(() {
                                  if (musicIndex >= 3) {
                                    musicIndex = 0;
                                  } else {
                                    musicIndex++;
                                  }
                                  room = apiService.changeSettings('music', music[musicIndex]);
                                });
                              },
                            ),
                            RoomColor(
                              room: snapshot.data!,
                              onTap: () {
                                setState(() {
                                  if (colorIndex >= 6) {
                                    colorIndex = 0;
                                  } else {
                                    colorIndex++;
                                  }
                                  room = apiService.changeSettings('room_colour', color[colorIndex]);
                                });
                              },
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