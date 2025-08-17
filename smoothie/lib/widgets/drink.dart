import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SmoothieDrink extends StatelessWidget{
  final double amount;
  final Color color;
  const SmoothieDrink({super.key, required this.amount, required this.color});

  Color darken(color, amount){
    final hsl = HSLColor.fromColor(color);
    final dark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return dark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 500,
          height: 750,
          child: Align(
            alignment: Alignment.topRight,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [color, color, Colors.transparent, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0, 1 - amount.clamp(0, 1), 1 - amount.clamp(0, 1), 1],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: SvgPicture.asset('assets/smoothie_cup_mask.svg',)
            ),
          ),
        ),
        SizedBox(
          width: 500,
          height: 750,
          child: Align(
            alignment: Alignment.topRight,
            child: ShaderMask(
              shaderCallback: (bounds) {
                final level = (1 - amount.clamp(0.0, 1.0));
                double thick = 15;
                final half = thick / bounds.height;
                double offset = 450.0;
                final offsetlevel = (level + offset / bounds.height).clamp(0.0, 1.0);
                final down = (offsetlevel - half).clamp(0.0, 1.0);
                final up = (offsetlevel + half).clamp(0.0, 1.0);
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    darken(color, 0.1),
                    darken(color, 0.1),
                    Colors.transparent,
                    Colors.transparent
                  ],
                  stops: [0.0, down, down, up, up, 1.0]
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: SvgPicture.asset('assets/smoothie_cup_mask.svg'),
            ),
          ),
        )
      ],
    );
  }
}