import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/questions.dart';
import 'package:quiz/scoreboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 64, 109, 70),
      ),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 64, 109, 70),
      // appBar: AppBar(title: Icon(Icons.leaderboard_rounded), backgroundColor: Colors.transparent,),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/foto_startscherm.jpg',
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 50,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        'Welke vlag hoort bij welk land?',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 17,
                          bottom: 17,
                        ),
                      ),
                      child: Text(
                        'Start de quiz',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 1,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScoreboardScreen(),
                  )
                );
              },
              icon: Icon(Icons.leaderboard_rounded, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
