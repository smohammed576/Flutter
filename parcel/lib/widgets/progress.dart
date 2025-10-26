import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/models/driver.dart';
import 'package:parcel/widgets/driver.dart';

class ProgressBottomSheet extends StatelessWidget{
  final Driver driver;
  const ProgressBottomSheet({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DeliveryDriver(
            driver: driver
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Track Progress', style: TextStyle(
                      color: AppColors.crow,
                      fontSize: 14
                    ),),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Collapse', style: TextStyle(
                        color: AppColors.crow,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 16
                      ),),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                  color: AppColors.darkgreen,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Are You Satified With The Job?', style: TextStyle(
                        color: AppColors.white,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 16
                      ),),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 35,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                side: BorderSide(
                                  color: AppColors.white
                                )
                              ),
                              onPressed: (){},
                              child: Text('I am not', style: TextStyle(
                                color: AppColors.white
                              ),),
                            ),
                          ),
                          SizedBox(width: 10,),
                          SizedBox(
                            width: 100,
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: AppColors.white
                              ),
                              onPressed: (){},
                              child: Text('Yes I am', style: TextStyle(
                                color: AppColors.darkgreen,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle_outline_outlined, color: AppColors.green, size: 20),
                              SizedBox(width: 10,),
                              Text('Package Delivered', style: TextStyle(
                                color: AppColors.crow,
                                fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                          Text('02:47pm', style: TextStyle(
                            color: AppColors.black.withAlpha(100),
                            fontSize: 12
                          ),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/images/photo.png', fit: BoxFit.cover, height: 150, width: MediaQuery.sizeOf(context).width,),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Delivery in progress...', style: TextStyle(
                                color: AppColors.crow,
                              ),),
                            ],
                          ),
                          Text('02:47pm', style: TextStyle(
                            color: AppColors.black.withAlpha(100),
                            fontSize: 12
                          ),)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.only(top: 20, left: 20, right: 15, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle_outline_outlined, color: AppColors.green, size: 20),
                              SizedBox(width: 10,),
                              Text('Package has been picked up', style: TextStyle(
                                color: AppColors.crow,
                                fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('02:47pm', style: TextStyle(
                            color: AppColors.black.withAlpha(100),
                            fontSize: 12
                          ),),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.only(top: 20, left: 20, right: 15, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Invoice Generated', style: TextStyle(
                                color: AppColors.crow,
                                fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: 10,),
                              Text('Call out charges will be refunded on acceptance', style: TextStyle(
                                color: AppColors.crow.withAlpha(200),
                                fontSize: 13,
                              ),),
                              SizedBox(height: 20,),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SizedBox(
                                    width: 140,
                                    height: 50,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        side: BorderSide(color: AppColors.green),
                                        padding: EdgeInsets.zero
                                      ),
                                      onPressed: (){},
                                      child: Text('View Invoice', style: TextStyle(
                                        color: AppColors.avatargreen
                                      ),),
                                    ),
                                  ),
                                  Positioned(
                                    top: -10,
                                    right: -10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.red,
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                      width: 25,
                                      height: 25,
                                      child: Center(
                                        child: Text('1', style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        ),),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('02:47pm', style: TextStyle(
                            color: AppColors.black.withAlpha(100),
                            fontSize: 12
                          ),),
                        ],
                      )
                    ],
                  ),
                ),SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.only(top: 20, left: 20, right: 15, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rider has Arrived at the location', style: TextStyle(
                                color: AppColors.crow,
                                fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: 10,),
                              Text('Rider has arrived', style: TextStyle(
                                color: AppColors.crow.withAlpha(200),
                                fontSize: 13,
                              ),),
                              SizedBox(height: 10,)
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('02:47pm', style: TextStyle(
                            color: AppColors.black.withAlpha(100),
                            fontSize: 12
                          ),),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}