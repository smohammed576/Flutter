import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/models/driver.dart';

class DeliveryDriver extends StatelessWidget{
  final Driver driver;
  const DeliveryDriver({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.crow,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
      ),
      padding: EdgeInsets.all(25),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.avatargreen),
                  borderRadius: BorderRadius.circular(200)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset('assets/${driver.image}', width: 45, height: 45, fit: BoxFit.cover,),
                ),
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(driver.name, style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500
                  ),),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${driver.rating} ', style: TextStyle(
                            color: AppColors.white,
                            fontFamily: 'Geist'
                          )
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star_rate, color: AppColors.gold, size: 18,)
                        )
                      ]
                    ),
                  )
                ],
              )
            ],
          ),
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: CircleBorder(),
              backgroundColor: AppColors.green
            ),
            onPressed: (){},
            icon: Icon(Icons.phone, color: AppColors.white),
          )
        ],
      ),
    );
  }
}