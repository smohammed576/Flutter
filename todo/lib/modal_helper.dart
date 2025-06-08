// import 'package:flutter/material.dart';
// import 'package:todo/constants/colors.dart';

// Future<void> _displayModalBottomSheet() {
//     return showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(autofocus: true, controller: _textController),
//               ),
//               SizedBox(width: 10),
//               IconButton(
//                 style: IconButton.styleFrom(
//                   backgroundColor:
//                       Theme.of(context).brightness == Brightness.dark
//                       ? darkTheme.cardColor
//                       : lightTheme.cardColor,
//                   foregroundColor: Colors.white,
//                 ),
//                 onPressed: () {
//                   if (_textController.text.trim().isNotEmpty) {
//                     setState(() {
//                       list.add(
//                         Task(text: _textController.text, checked: false),
//                       );
//                       _textController.clear();
//                     });
//                     saveTask();
//                   }
//                 },
//                 icon: Icon(Icons.keyboard_arrow_up),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }