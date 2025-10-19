import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourinarow/constants/colors.dart';
import 'package:fourinarow/widgets/button.dart';
import 'package:fourinarow/widgets/line.dart';

class GameScreen extends StatefulWidget{
  final bool singleMode;
  const GameScreen({super.key, required this.singleMode});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const int rows = 6;
  static const int columns = 7;
  List<List<int>> board = List.generate(rows, (index) => List.filled(columns, 0));
  int player = 1;
  bool gameOver = false;
  String winner = '';
  Offset? startLine;
  Offset? endLine;
  List<double> positions = [];

  @override
  void initState() {
    super.initState();
    bool playerStarts = Random().nextBool();
    player = playerStarts ? 1 : 2;
    if(!playerStarts && widget.singleMode){
      Future.delayed(Duration(milliseconds: 500), () {
        randomColumn();
      });
    }
  }

  bool checkGameState(int player){
    if(board[0].contains(0)){
      for(int row = 0; row < rows; row++){
        for(int column = 0; column <= columns - 4; column++){
          if(board[row][column] == player && 
            board[row][column + 1] == player && 
            board[row][column + 2] == player && 
            board[row][column + 3] == player){
            Future.delayed(Duration(milliseconds: 400), () {
              setState(() {
                gameOver = true;
                winner = player == 1 ? 'Yellow' : 'Red';
                startLine = Offset(column.toDouble(), row.toDouble());
                endLine = Offset(column + 3, row.toDouble());
                positions = [2, 2];
              });
            });
          }
        }
      }
      if(!gameOver){
        for(int column = 0; column < columns; column++){
          for(int row = 0; row <= rows - 4; row++){
            if(board[row][column] == player && 
              board[row + 1][column] == player && 
              board[row + 2][column] == player && 
              board[row + 3][column] == player){
              Future.delayed(Duration(milliseconds: 400), (){
                setState(() {
                  gameOver = true;
                  winner = player == 1 ? 'Yellow' : 'Red';
                  startLine = Offset(column.toDouble(), row.toDouble());
                  endLine = Offset(column.toDouble(), row + 3);
                  positions = [0.55, 2];
                });
              });
            }
          }
        }
      }
      if(!gameOver){
        for(int row = 0; row <= rows - 4; row++){
          for(int column = 0; column <= columns - 4; column++){
            if(board[row][column] == player && 
              board[row + 1][column + 1] == player && 
              board[row + 2][column + 2] == player && 
              board[row + 3][column + 3] == player){
              Future.delayed(Duration(milliseconds: 400), () {
                setState(() {
                  gameOver = true;
                  winner = player == 1 ? 'Yellow' : 'Red';
                  startLine = Offset(column.toDouble(), row.toDouble());
                  endLine = Offset(column + 3, row + 3);
                  positions = [0.55, 2];
                });
              });
            }
          }
        }
      }
      if(!gameOver){
        for(int row = 3; row < rows; row++){
          for(int column = 0; column <= columns - 4; column++){
            if(board[row][column] == player && 
              board[row - 1][column + 1] == player && 
              board[row - 2][column + 2] == player && 
              board[row - 3][column + 3] == player){
              Future.delayed(Duration(milliseconds: 400), () {
                setState(() {
                  gameOver = true;
                  winner = player == 1 ? 'Yellow' : 'Red';
                  startLine = Offset(column.toDouble(), row.toDouble());
                  endLine = Offset(column + 3, row - 3);
                  positions = [2, 0.55];
                });
              });
            }
          }
        }
      }
    }
    else{
      Future.delayed(Duration(milliseconds: 400), () {
        setState(() {
          gameOver = true;
        });
      });
    }
    return gameOver;
  }

  int randomColumn(){
    int number = Random().nextInt(columns);
    if(board[0].contains(0)){
      while(board[0][number] != 0){
        number = Random().nextInt(columns);
      }
    }
    else{
      Future.delayed(Duration(milliseconds: 400), () {
        setState(() {
          gameOver = true;
        });
      });
    }
    dropChip(number);
    return number;
  }

  void dropChip(int column){
    if(!gameOver){
      for(int row = rows - 1; row >= 0; row--){
        if(board[row][column] == 0){
          setState(() {
            board[row][column] = player;
            checkGameState(player);
            player = player == 1 ? 2 : 1;
            if(player == 2 && !checkGameState(player) && widget.singleMode){
              Future.delayed(Duration(milliseconds: 800), () {
                randomColumn();
              });
            }
          });
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset('assets/icon_home.svg', colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
        ),
        centerTitle: true,
        title: gameOver ? null : SvgPicture.asset('assets/chip_${player == 1 ? 'yellow' : 'red'}.svg'),
        toolbarHeight: 150,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns
              ), 
              itemCount: rows * columns,
              itemBuilder: (context, index) {
                int row = index ~/ columns;
                int column = index % columns;
                String color;
                if(board[row][column] == 1){
                  color = 'yellow';
                } else if(board[row][column] == 2){
                  color = 'red';
                } else{
                  color = 'white';
                }
                return Container(
                  width: 45,
                  height: 45,
                  margin: EdgeInsets.all(5),
                  child: color == 'white' ? null : TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: -200, end: 0), 
                    duration: Duration(milliseconds: 500), 
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: child!,
                      );
                    },
                    child: SvgPicture.asset('assets/chip_$color.svg'),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(AppColors.background, BlendMode.srcOut),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns
                        ), 
                        itemCount: rows * columns,
                        itemBuilder: (context, index) {
                          int column = index % columns;
                          return GestureDetector(
                            onTap: () => gameOver ? null : dropChip(column),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              width: 45,
                              height: 45,
                              margin: EdgeInsets.all(5),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
          if(startLine != null && endLine != null)
          Positioned.fill(
            top: 20,
            left: 10,
            right: 10,
            // bottom: 20,
            bottom: 285,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  painter: LinePainter(
                    startLine!, 
                    endLine!, 
                    width: (constraints.maxWidth / columns), 
                    height: (constraints.maxHeight / rows),
                    positions: positions
                  )
                );
              }
            )
          ),
          if(gameOver)
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 20,),
              Text(winner != '' ? '$winner wins!' : 'No winner', style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 35
              ),),
              SizedBox(height: 20,),
              WhiteButton(
                text: 'Play again', 
                onTap: (){
                  setState(() {
                    board.clear();
                    board = List.generate(rows, (index) => List.filled(columns, 0));
                    gameOver = false;
                    winner = '';
                    startLine = null;
                    endLine = null;
                    positions = [];
                    if(player == 2 && widget.singleMode){
                      Future.delayed(Duration(milliseconds: 400), () {
                        randomColumn();
                      });
                    }
                  });
                }
              ),
              SizedBox(height: 100,)
            ],
          )
        ],
      ),
    );
  }
}