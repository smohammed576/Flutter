import 'package:flutter/material.dart';
import 'package:game2048/constants/colors.dart';
import 'package:game2048/screens/game.dart';
import 'package:game2048/widgets/button.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeStateScreen();
}

class _HomeStateScreen extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('2048 - The Modern Edition', style: GoogleFonts.shadowsIntoLightTwo(
              color: AppColors.color,
              fontSize: 32
            ),),
            SizedBox(height: 60,),
            Text('Welcome!', style: GoogleFonts.shadowsIntoLightTwo(
              color: AppColors.color,
              fontSize: 30
            ),),
            SizedBox(height: 60,),
            OutlineButton(text: 'New Game', fontsize: 30, onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(),
                )
              );
            })
          ],
        ),
      ),
    );
  }
}