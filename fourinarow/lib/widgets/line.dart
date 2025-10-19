import 'package:flutter/material.dart';
import 'package:fourinarow/constants/colors.dart';

class LinePainter extends CustomPainter{
  final Offset start;
  final Offset end;
  final double width;
  final double height;
  final List<double> positions;

  LinePainter(this.start, this.end, {required this.width, required this.height, required this.positions});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white
      ..strokeWidth = width * 0.25
      ..strokeCap = StrokeCap.round;
    
    // final width = size.width / 7;
    // final height = size.height / 6;

    // final marginX = width * 0.12;
    // final marginY = height * 0.12;
    const double margin = 0;

    //horizontal this
    //vertical 1 1
    //dia1 2 0.55
    //dia2 0.55 2

    final startOffset = Offset(
      (start.dx * width) + width / 2 + margin, 
      (start.dy * height) + height / positions[0] + margin
    );
    final endOffset = Offset(
      (end.dx * width) + width / 2 + margin, 
      (end.dy * height) + height / positions[1] + margin
    );

    canvas.drawLine(startOffset, endOffset, paint);
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) => true;
}