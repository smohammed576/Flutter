import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GameChip extends StatelessWidget{
  final double start;
  final double end;
  final double left;
  final String color;
  final VoidCallback onEnd;
  const GameChip({super.key, required this.start, required this.end, required this.left, required this.color, required this.onEnd});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: start, end: end),
      duration: Duration(milliseconds: 900),
      curve: Curves.linear,
      builder: (context, value, child) {
        return Positioned(
          top: value,
          left: left,
          child: SizedBox(
            width: 45,
            height: 45,
            child: child!
          ),
        );
      },
      child: SvgPicture.asset('assets/chip_$color.svg'),
    );
  }
}