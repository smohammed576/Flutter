import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';

class TypeButton extends StatelessWidget{
  final String label;
  final String image;
  final VoidCallback onTap;
  const TypeButton({super.key, required this.label, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.4 - 10,
      height: MediaQuery.sizeOf(context).width * 0.4 - 10,
      margin: EdgeInsets.only(right: 5, bottom: 5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.zero
        ),
        onPressed: onTap, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/$image', width: 100,),
            SizedBox(height: 20,),
            Text(label, style: TextStyle(
              color: AppColors.crow,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),)
          ],
        )
      ),
    );
  }
}