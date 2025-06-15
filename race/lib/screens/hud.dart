import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:race/screens/race.dart';

class Hud extends StatefulWidget {
  static const id = 'Hud';
  const Hud(this.game, {super.key});
  final RaceScreen game;

  @override
  State<Hud> createState() => HudState();
}

class HudState extends State<Hud> {
  int score = 0;

  void getStars(int newScore) {
    setState(() {
      score = newScore;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.game.hudState = this;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Stack(
        alignment: AlignmentGeometry.directional(0, 250),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Image.asset('assets/count.png', width: 110)],
          ),
          Positioned(
            top: 9,
            left: 65,
            child: Text(
              '$score',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    shape: BeveledRectangleBorder(),
                    backgroundColor: Colors.black45,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    widget.game.getLeft();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    shape: BeveledRectangleBorder(),
                    backgroundColor: Colors.black45,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    widget.game.getRight();
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
