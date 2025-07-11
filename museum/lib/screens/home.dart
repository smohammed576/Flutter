import 'package:flutter/material.dart';
import 'package:museum/constants/colors.dart';
import 'package:museum/screens/explore.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeStateScreen();
}

class _HomeStateScreen extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Center(
              child: Image.asset('assets/images/logo.png', width: 80,),
            ),
            SizedBox(height: 40,),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                child: Image.asset('assets/images/louvre.jpg', height: 350, fit: BoxFit.cover,)
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.background,
                    blurRadius: 5,
                    spreadRadius: 10,
                    offset: Offset(0, -4)
                  )
                ]
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Experience Art', style: TextStyle(
                      color: AppColors.sandcolor,
                      fontSize: 25
                    ),),
                    SizedBox(height: 10,),
                    Text('We are thrilled to invite you to join us for an extraordinary event that will immerse you in the world of art.', style: TextStyle(
                      color: AppColors.greycolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        alignment: Alignment.center
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExploreScreen()
                          )
                        );
                      },
                      child: Text('Explore Now', style: TextStyle(
                        fontSize: 20,
                        color: AppColors.background
                      ),),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}