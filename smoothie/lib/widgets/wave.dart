import 'package:flutter/material.dart';

class SmoothieWave extends StatefulWidget{
  final Color color;
  final double height;
  const SmoothieWave({super.key, required this.color, required this.height});

  @override
  State<SmoothieWave> createState() => _SmoothieWaveState();
}

class _SmoothieWaveState extends State<SmoothieWave> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> waveheight;

  @override
  void initState(){
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this
    );
    waveheight = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut)
    );
    animationController.forward().then((_) => animationController.stop());
  }

  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: waveheight, 
      builder: (context, child) {
        return Positioned(
          bottom: widget.height,
          left: 180,
          // right: 0,
          child: Container(
            height: waveheight.value,
            color: widget.color.withAlpha(255),
            width: 220,
          )
        );
      },
    );
  }
}