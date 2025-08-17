import 'package:flutter/material.dart';
import 'package:smoothie/constants/colors.dart';
import 'package:smoothie/screens/home.dart';
import 'package:smoothie/widgets/drink.dart';
import 'package:smoothie/widgets/logo.dart';

class OrderNumberScreen extends StatefulWidget{
  final String name;
  const OrderNumberScreen({super.key, required this.name});

  @override
  State<OrderNumberScreen> createState() => _OrderNumberScreenState();
}

class _OrderNumberScreenState extends State<OrderNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingLogo(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.background
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 450,
                    child: Card(
                      color: AppColors.white,
                      elevation: 10,
                      shadowColor: AppColors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bestelnummer', style: TextStyle(
                              color: AppColors.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 35
                            ),),
                            Text("'${widget.name}'", style: TextStyle(
                              color: AppColors.orange,
                              fontWeight: FontWeight.w600,
                              fontSize: 25
                            ),),
                            Text('36', style: TextStyle(
                              color: AppColors.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 200,
                              height: 1
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 140,),
                  Row(
                    children: [
                      Text('Bestel een nieuwe smoothie', style: TextStyle(
                        color: AppColors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                      ),),
                      SizedBox(width: 10,),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.white,
                          shape: CircleBorder()
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen(),)
                        ),
                        icon: Icon(Icons.arrow_forward, color: AppColors.orange, size: 30,),
                      )
                    ],
                  )
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fromRect(
                  rect: Rect.fromCircle(center: Offset(290, 350), radius: 280),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.reversed
                    ),
                  ),
                ),
                SmoothieDrink(
                  amount: 0.55, 
                  color: AppColors.drinkColors['blauwebes'] ?? Colors.white
                ),
                Positioned(
                  bottom: -105,
                  left: 44,
                  child: SizedBox(
                    width: 500,
                    height: 930,
                    child: Image.asset('assets/smoothie_cup_empty.png', fit: BoxFit.cover, opacity: AlwaysStoppedAnimation(0.8),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}