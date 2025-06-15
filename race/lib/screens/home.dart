import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:race/screens/countdown.dart';
import 'package:race/screens/hud.dart';
import 'package:race/screens/paused.dart';
import 'package:race/screens/race.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'Home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selected = "pink";
  List colors = ['red', 'blue', 'yellow', 'pink'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Pick your car',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                fontSize: 45,
              ),
            ),
            SizedBox(
              height: 400,
              child: GridView.count(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: List.generate(colors.length, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: selected == colors[index]
                          ? BoxBorder.all(
                              color: const Color(0xFF76B92C),
                              width: 3,
                            )
                          : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = colors[index];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            'assets/start_${colors[index]}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF76B92C),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameWidget(
                      game: RaceScreen(color: selected, context: context),
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
                'Start race',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
