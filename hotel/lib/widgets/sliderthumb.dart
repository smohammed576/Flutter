import 'package:flutter/material.dart';

class SliderThumb extends SliderComponentShape {
  final double thumbRadius;

  const SliderThumb({required this.thumbRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = sliderTheme.overlayColor ?? Colors.white;

    const iconData = Icons.pause_rounded;
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.rtl,
    );
    textPainter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        fontSize: thumbRadius * 1.5,
        fontFamily: iconData.fontFamily,
        color: sliderTheme.thumbColor,
      ),
    );
    textPainter.layout();

    final Offset textCenter = Offset(
      center.dx - (textPainter.width / 2),
      center.dy - (textPainter.height / 2),
    );
    const cornerRadius = 50.0;

    canvas.drawRRect(
      RRect.fromRectXY(
        Rect.fromCenter(center: center, width: 50, height: 50),
        cornerRadius,
        cornerRadius,
      ),
      paint,
    );
    textPainter.paint(canvas, textCenter);
  }
}
