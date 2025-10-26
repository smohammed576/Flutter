import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';

class ParcelAppBar extends StatelessWidget{
  const ParcelAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: Icon(Icons.play_arrow_rounded, color: AppColors.green, size: 30,)
            ),
            Text('Back', style: TextStyle(
              color: AppColors.crow,
              fontSize: 15,
              decoration: TextDecoration.underline,
              height: 1.2
            ),)
          ],
        ),
      ),
      TextButton(
          onPressed: (){},
          child: Text('Cancel order', style: TextStyle(
              color: AppColors.crow,
              fontSize: 15,
              decoration: TextDecoration.underline,
              height: 1.2,
              fontWeight: FontWeight.bold
            ),),
        )
        ],
      ),
    );
  }
}