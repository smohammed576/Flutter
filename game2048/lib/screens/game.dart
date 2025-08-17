import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game2048/constants/colors.dart';
import 'package:game2048/widgets/button.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget{
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameStateScreen();
}

class _GameStateScreen extends State<GameScreen>{
  int score = 0;
  int highscore = 0;
  List<List<int>> board = List.generate(4, (index) => List.filled(4, 0),);

  @override
  void initState(){
    super.initState();
    addTile();
    addTile();
  }

  void addTile(){
    List empty = <Point>[];
    for(int i = 0; i < 4; i++){
      for(int index = 0; index < 4; index++){
        if(board[i][index] == 0){
          empty.add(Point(i, index));
        }
      }
    }

    if(empty.isNotEmpty){
      final random = Random();
      final number = empty[random.nextInt(empty.length)];
      board[number.x][number.y] = random.nextDouble() > 0.1 ? 2 : 4;
    }
  }

  List<int> moveRow(List<int> row){
    List<int> newRow = row.where((item) => item != 0).toList();
    for(int i = 0; i < newRow.length - 1; i++){
      if(newRow[i] == newRow[i + 1]){
        newRow[i] *= 2;
        score += newRow[i];
        newRow[i + 1] = 0;
      }
    }

    newRow = newRow.where((item) => item != 0).toList();

    while(newRow.length < 4){
      newRow.add(0);
    }

    return newRow;
  }

  void moveUp(){
    print('up');
    setState(() {
      for(int i = 0; i < 4; i++){
        List<int> column = List.generate(4, (index) => board[index][i]);
        List<int> newColumn = moveRow(column);
        for(int index = 0; index < 4; index++){
          board[index][i] = newColumn[index];
        }
      }
      addTile();
    });
  }

  void moveDown(){
    print('down');
    setState(() {
      for(int i = 0; i < 4; i++){
        List<int> row = List.generate(4, (index) => board[index][i]);
        List<int> newRow = moveRow(row.reversed.toList()).reversed.toList();
        for(int index = 0; index < 4; index++){
          board[index][i] = newRow[index];
        }
      }
      addTile();
    });
  }

  void moveLeft(){
    print('left');
    setState(() {
      for(int i = 0; i < 4; i++){
        board[i] = moveRow(board[i]);
      }
      addTile();
    });
  }

  void moveRight(){
    print('right');
    setState(() {
      for(int i = 0; i < 4; i++){
        board[i] = moveRow(board[i].reversed.toList()).reversed.toList();
      }
      addTile();
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Current Score: $score', style: GoogleFonts.shadowsIntoLightTwo(
              color: AppColors.color,
              fontSize: 15
            ),),
            Text('Highscore: $highscore', style: GoogleFonts.shadowsIntoLightTwo(
              color: AppColors.color,
              fontSize: 15
            ),),
            OutlineButton(
            text: 'Undo', 
            fontsize: 15, 
            onTap: (){}
          ),
          OutlineButton(
            text: 'Pause', 
            fontsize: 15, 
            onTap: (){}
          ),
          ],
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          print('this $details');
          if(details.delta.dx.abs() > details.delta.dy.abs()){
            moveRight();
          }
          else{
            moveLeft();
          }
        },
        onVerticalDragEnd: (details) {
          if(details.localPosition.dy > details.localPosition.dx){
            moveDown();
          }
          else{
            moveUp();
          }
        },
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: 16,
            itemBuilder: (context, index) {
              int row = index ~/ 4;
              int column = index % 4;
              int value = board[row][column];
              return Container(
                decoration: BoxDecoration(
                  color: value == 0 ? null : AppColors.values['$value'],
                  border: Border.all(width: 0.6, color: AppColors.color)
                ),
                child: Center(
                  child: value == 0 ? null : Text('$value', style: GoogleFonts.shadowsIntoLightTwo(
                    color: value == 2 || value == 4 || value == 8 ? AppColors.greycolor : AppColors.whitecolor,
                    fontSize: 30
                  ),), 
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}