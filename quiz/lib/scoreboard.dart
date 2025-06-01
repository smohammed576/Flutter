import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz/main.dart';
import 'package:quiz/player.dart';
import 'package:quiz/questions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class ScoreboardScreen extends StatefulWidget {
  final int? score;
  final int? time;

  const ScoreboardScreen({super.key, this.score, this.time});

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  bool submitted = false;
  List<Player> scoreboard = [];
  String name = '';
  String path = '';

  @override
  void initState() {
    super.initState();
    loadData().then((_) {
      if (widget.score != null && !submitted) {
        _dialogBuilder(context);
        submitted = true;
      }
    });
  }

  Future<void> saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    final json = scoreboard.map((score) => score.toJson()).toList();
    prefs.setString('scoreboard', jsonEncode(json));
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('scoreboard');
    if (string != null) {
      final List<dynamic> json = jsonDecode(string);
      setState(() {
        scoreboard = json.map((item) => Player.fromJson(item)).toList();
        scoreboard.sort((a, b) {
          if (b.score! != a.score!) {
            return b.score!.compareTo(a.score!);
          } else {
            return a.time!.compareTo(b.time!);
          }
        });
      });
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            iconSize: 25,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: Icon(Icons.home_rounded),
        ),
        title: Text(
          'Scorebord',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF111111),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionScreen()),
              );
            },
            child: Text(
              'Start de quiz',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: scoreboard.length,
          itemBuilder: (context, index) {
            final player = scoreboard[index];
            int m, s;
            m = player.time! ~/ 60;
            s = player.time! - (m * 60);

            String formattedTime = '$m:${s.toString().padLeft(2, '0')}';

            Color color = Colors.transparent;
            if (index == 0) {
              color = const Color(0xFFEDC658);
            } else if (index == 1) {
              color = const Color(0xFFB9B9B9);
            } else if (index == 2) {
              color = const Color(0xFFC18661);
            }
            return Container(
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xB3F0F0F0),
                borderRadius: BorderRadius.circular(5),
                border: name == player.name
                    ? BoxBorder.all(color: const Color(0xFFEDC658), width: 2)
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: color,
                        ),
                        child: Align(
                          child: Text(
                            '${index + 1}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          player.imagePath,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        player.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12,
                        ),
                        child: Align(
                          child: Text(
                            '${player.score}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<PermissionStatus> requestPermission() async {
    return await Permission.photos.request();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              actionsAlignment: MainAxisAlignment.center,
              title: Text(
                'Gefeliciteerd, je score is ${widget.score}!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              elevation: 10,
              content: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE1E1E1),
                    ),
                    onPressed: () async {
                      // PermissionStatus permissionStatus = await requestPermission();
                      // if(permissionStatus == PermissionStatus.granted){
                      final pick = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pick != null) {
                        setState(() {
                          path = pick.path;
                        });
                      }
                      // }
                      // openAppSettings();
                      // final pick = await ImagePicker().pickImage(
                      //   source: ImageSource.gallery,
                      // );
                      // if (pick != null) {
                      //   setState(() {
                      //     path = pick.path;
                      //   });
                      // } werkt niet op web, so thats why its commented:) maar yk nu kan je zien dat de functie er wel is
                    },
                    // child: Icon(Icons.photo_size_select_actual_outlined),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: path.isEmpty
                          ? Icon(
                              Icons.photo_size_select_actual_outlined,
                              size: 40,
                            )
                          : Image.network(
                              path,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Jouw naam...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8E8E8),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Annuleren',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111111),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  ),
                  onPressed: () {
                    if (name.isNotEmpty && path.isNotEmpty) {
                      setState(() {
                        scoreboard.add(
                          Player(
                            name: name,
                            imagePath: path,
                            score: widget.score,
                            time: widget.time,
                          ),
                        );
                      });
                      saveScore();
                      Future.delayed(Duration(milliseconds: 100), () {
                        int index = scoreboard.indexWhere(
                          (item) => item.name == name,
                        );
                        if (index != -1) {
                          _scrollController.jumpTo(
                            (index - 1).clamp(0, scoreboard.length - 1) * 50,
                          );
                        }
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
