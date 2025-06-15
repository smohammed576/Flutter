import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:race/screens/race.dart';

class Countdown extends StatefulWidget {
  static const id = 'countdown';
  final RaceScreen game;
  const Countdown(this.game, {super.key});

  @override
  State<Countdown> createState() => CountdownState();
}

class CountdownState extends State<Countdown> {
  int countNumber = 3;

  void getCount(int counts) {
    setState(() {
      countNumber = counts;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.game.counter = this;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: Colors.black54)),
        Center(
          child: Text(
            '$countNumber',
            style: GoogleFonts.inter(
              fontSize: 150,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
