import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:race/screens/countdown.dart';
import 'package:race/screens/home.dart';
import 'package:race/screens/hud.dart';
import 'package:race/screens/paused.dart';
import 'package:race/screens/race.dart';

Future<void> dialogBuilder(BuildContext context, String status, String color) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            actionsAlignment: MainAxisAlignment.center,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      status,
                      style: GoogleFonts.inter(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: status == 'Crashed!'
                            ? const Color(0xFFEF2F3D)
                            : Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF76B92C),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameWidget(
                        game: RaceScreen(color: color, context: context),
                        overlayBuilderMap: {
                          Hud.id: (_, RaceScreen game) => Hud(game),
                          Countdown.id: (_, RaceScreen game) => Countdown(game),
                          PausedScreen.id: (_, RaceScreen game) =>
                              PausedScreen(game),
                        },
                        initialActiveOverlays: const [Hud.id],
                      ),
                    ),
                  );
                },
                child: Text(
                  'Again',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
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
