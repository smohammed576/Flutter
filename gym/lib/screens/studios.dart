import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/constants/colors.dart';
import 'package:gym/models/studio/broadcast.dart';
import 'package:gym/models/studio/studio.dart';
import 'package:gym/helpers/details.helper.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class StudiosScreen extends StatefulWidget {
  const StudiosScreen({super.key});

  @override
  State<StudiosScreen> createState() => _StudiosScreenState();
}

class _StudiosScreenState extends State<StudiosScreen> {
  Studio? studio;
  Map<String, Broadcast?>? broadcasts;
  String? theme;

  @override
  void initState() {
    super.initState();
    getBroadcasts();
    getTheme();
  }

  void getBroadcasts() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    final List<dynamic> list = data['broadcast_information'];
    setState(() {
      broadcasts = {
        '0': Broadcast.fromJson(list[0]),
        '1': Broadcast.fromJson(list[1]),
      };
    });
  }

  void getTheme() async {
    await Hive.openBox('theme');
    setState(() {
      theme = Hive.box('theme').get('color');
    });
  }

  Future<void> getStudio(int number) async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    setState(() {
      studio = Studio.fromJson(data['studios'][number]);
    });
  }

  formatDate(value) {
    final formatString = DateFormat('yyyy-MM-dd').parse(value);
    final date = DateFormat.MMMMd('en_US').format(formatString);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: LightColors.lightColors[theme]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Studios',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${broadcasts!['0']?.message}',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text('${formatDate(broadcasts!['0']?.date)}'),
                  SizedBox(height: 5),
                  Text(
                    '${broadcasts!['1']?.message}',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text('${formatDate(broadcasts!['1']?.date)}'),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/Map.png', fit: BoxFit.cover),
                  Positioned(
                    bottom: 150,
                    left: 100,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        elevation: 20,
                        shadowColor: LightColors.lightColors[theme],
                        shape: BeveledRectangleBorder(),
                      ),
                      onPressed: () async {
                        await getStudio(1);
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return StudioDetails(
                              studio: studio!,
                              theme: theme ?? 'green',
                              onTap: () {},
                            );
                          },
                        );
                      },
                      icon: Image.asset(
                        'assets/Icon.png',
                        width: 50,
                        color: theme != 'green'
                            ? BlendColors.blendColors[theme]
                            : null,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 50,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        elevation: 20,
                        shadowColor: LightColors.lightColors[theme],
                        shape: BeveledRectangleBorder(),
                      ),
                      onPressed: () async {
                        await getStudio(0);
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return StudioDetails(
                              studio: studio!,
                              theme: theme ?? 'green',
                              onTap: () {},
                            );
                          },
                        );
                      },
                      icon: Image.asset(
                        'assets/Icon.png',
                        width: 50,
                        color: theme != 'green'
                            ? BlendColors.blendColors[theme]
                            : null,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
