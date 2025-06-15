import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:race/screens/race.dart';

class PausedScreen extends StatefulWidget {
  static const id = 'Paused';
  final RaceScreen game;
  const PausedScreen(this.game, {super.key});

  @override
  State<PausedScreen> createState() => PausedScreenState();
}

class PausedScreenState extends State<PausedScreen> {
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isPaused) ...[
          Positioned.fill(child: Container(color: Colors.black45)),
          Center(
            child: Text(
              'Paused',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 35,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
        Positioned(
          top: 15,
          right: 25,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shadowColor: Colors.grey,
              elevation: 10,
            ),
            onPressed: () {
              widget.game.pauseGame();
              setState(() {
                isPaused = !isPaused;
              });
            },
            icon: Icon(isPaused ? Icons.play_arrow : Icons.pause, size: 30),
          ),
        ),
      ],
    );
  }
}
