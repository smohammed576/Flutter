import 'package:flutter/material.dart';
import 'package:fourinarow/screens/game.dart';
import 'package:fourinarow/widgets/button.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WhiteButton(
              text: 'Single player', 
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameScreen(singleMode: true))
              )
            ),
            SizedBox(height: 20,),
            WhiteButton(
              text: 'Two player', 
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameScreen(singleMode: false))
              )
            ),
          ],
        ),
      ),
    );
  }
}