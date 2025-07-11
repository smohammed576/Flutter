import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:museum/constants/colors.dart';

class TicketingScreen extends StatefulWidget{
  const TicketingScreen({super.key});

  @override
  State<TicketingScreen> createState() => _TicketingStateScreen();
}

class _TicketingStateScreen extends State<TicketingScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/museum.jpg'), fit: BoxFit.cover,),
              ),
              width: double.infinity,
              height: 250,
              child: Center(
                child: Text('Official Ticketing Service', style: TextStyle(
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: AppColors.color
                ),),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.background,
                    spreadRadius: 40,
                    blurRadius: 10,
                    offset: Offset(0, -10)
                  )
                ]
              ),
            ),
            DatePickerTheme(
              data: DatePickerThemeData(
                backgroundColor: Colors.transparent,
                dayForegroundColor: WidgetStateProperty.all(AppColors.color),
                cancelButtonStyle: ButtonStyle(),
                dayStyle: TextStyle(
                  color: AppColors.color
                ),
                weekdayStyle: TextStyle(
                  color: AppColors.yellow
                ),
                elevation: 0
              ),
              child: DatePickerDialog(
                firstDate: DateTime(1999), 
                lastDate: DateTime(2999), 
                initialDate: DateTime(2025, 9, 13),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.yellow
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Total: €44', style: TextStyle(
              color: AppColors.background,
              fontSize: 25
            ),),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.background,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15)
              ),
              onPressed: (){},
              child: Text('Checkout', style: TextStyle(
                color: AppColors.yellow,
                fontSize: 20
              ),),
            )
          ],
        ),
      ),
    );
  }
}