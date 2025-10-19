// import 'dart:ui';

// class GameStateService{
//   static const int rows = 6;
//   static const int columns = 7;

//   static Map<String, dynamic> checkGameState(List<List<int>> board, int player){
//     Offset? startLine;
//     Offset? endLine;

//     bool gameOver = false;
//     String winner = '';
//     List<double> positions = [];


//     if(board[0].contains(0)){
//       for(int row = 0; row < rows; row++){
//         for(int column = 0; column <= columns - 4; column++){
//           if(board[row][column] == player && 
//             board[row][column + 1] == player && 
//             board[row][column + 2] == player && 
//             board[row][column + 3] == player){
//             Future.delayed(Duration(milliseconds: 400), () {
//                 gameOver = true;
//                 winner = player == 1 ? 'Yellow' : 'Red';
//                 startLine = Offset(column.toDouble(), row.toDouble());
//                 endLine = Offset(column + 3, row.toDouble());
//                 positions = [2, 2];
//             });
//           }
//         }
//       }
//       if(!gameOver){
//         for(int column = 0; column < columns; column++){
//           for(int row = 0; row <= rows - 4; row++){
//             if(board[row][column] == player && 
//               board[row + 1][column] == player && 
//               board[row + 2][column] == player && 
//               board[row + 3][column] == player){
//               Future.delayed(Duration(milliseconds: 400), (){
//                   gameOver = true;
//                   winner = player == 1 ? 'Yellow' : 'Red';
//                   startLine = Offset(column.toDouble(), row.toDouble());
//                   endLine = Offset(column.toDouble(), row + 3);
//                   positions = [0.55, 2];
//                 });
//             }
//           }
//         }
//       }
//       if(!gameOver){
//         for(int row = 0; row <= rows - 4; row++){
//           for(int column = 0; column <= columns - 4; column++){
//             if(board[row][column] == player && 
//               board[row + 1][column + 1] == player && 
//               board[row + 2][column + 2] == player && 
//               board[row + 3][column + 3] == player){
//               Future.delayed(Duration(milliseconds: 400), () {
//                   gameOver = true;
//                   winner = player == 1 ? 'Yellow' : 'Red';
//                   startLine = Offset(column.toDouble(), row.toDouble());
//                   endLine = Offset(column + 3, row + 3);
//                   positions = [0.55, 2];
//                 });
//             }
//           }
//         }
//       }
//       if(!gameOver){
//         for(int row = 3; row < rows; row++){
//           for(int column = 0; column <= columns - 4; column++){
//             if(board[row][column] == player && 
//               board[row - 1][column + 1] == player && 
//               board[row - 2][column + 2] == player && 
//               board[row - 3][column + 3] == player){
//               Future.delayed(Duration(milliseconds: 400), () {
//                   gameOver = true;
//                   winner = player == 1 ? 'Yellow' : 'Red';
//                   startLine = Offset(column.toDouble(), row.toDouble());
//                   endLine = Offset(column + 3, row - 3);
//                   positions = [2, 0.55];
//                 });
//             }
//           }
//         }
//       }
//     }
//     else{
//       Future.delayed(Duration(milliseconds: 400), () {
//           gameOver = true;
//       });
//     }
//     return {
//       'gameOver': gameOver,
//       'startLine': startLine,
//       'endLine': endLine,
//       'winner': winner,
//       'positions': positions
//     };
//   }
// }