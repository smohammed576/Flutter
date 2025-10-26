import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';

class LinePainter extends CustomPainter{
  final Offset start;
  final Offset end;
  const LinePainter(this.start, this.end);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.green
      ..strokeWidth = 10;

    final startOffset = Offset(
      start.dx,
      start.dy
    );

    final endOffset = Offset(
      end.dx,
      end.dy
    );

    canvas.drawLine(startOffset, endOffset, paint);
  }
  
  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) => true;
}