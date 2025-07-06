import 'package:flutter/material.dart';
import 'package:gym/constants/colors.dart';

class HomeCard extends StatelessWidget {
  final String name;
  final String icon;
  final String theme;
  final VoidCallback onTap;

  const HomeCard({
    super.key,
    required this.name,
    required this.icon,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.center,
                stops: List.filled(2, 1),
                tileMode: TileMode.clamp,
                colors: [
                  LightColors.lightColors[theme] ?? Colors.green,
                  Colors.white,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Image.asset('assets/Icons/$icon', width: 60),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appColors[theme],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
