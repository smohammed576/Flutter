import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/screens/datetime.dart';
import 'package:parcel/widgets/appbar.dart';
import 'package:parcel/widgets/greenbutton.dart';
import 'package:parcel/widgets/input.dart';

class DeliveryScreen extends StatefulWidget{
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 50), 
        child: ParcelAppBar()
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/map.png', fit: BoxFit.cover,),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: AppColors.white
            ),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: AppColors.green.withAlpha(100)
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.navigation_outlined, color: AppColors.green, size: 35,),
                      ),
                      SizedBox(width: 20,),
                      SizedBox(
                        width: 270,
                        child: Text('Where is the package being delivered to?', style: TextStyle(
                          color: AppColors.crow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  InputWithLabel(
                    label: 'Enter Postcode', 
                    hint: '', 
                    bigText: false, 
                    controller: textController
                  ),
                  SizedBox(height: 35,),
                  InputWithLabel(
                    label: 'Street Address', 
                    hint: '', 
                    bigText: false, 
                    controller: textController
                  ),
                  SizedBox(height: 35,),
                  InputWithLabel(
                    label: 'Street Address 2 (Optional)', 
                    hint: '', 
                    bigText: false, 
                    controller: textController
                  ),
                  SizedBox(height: 35,),
                  InputWithLabel(
                    label: 'City / Town', 
                    hint: '', 
                    bigText: false, 
                    controller: textController
                  ),
                  SizedBox(height: 35,),
                  InputWithLabel(
                    label: 'Name of Reciever', 
                    hint: '', 
                    bigText: false, 
                    controller: textController
                  ),
                  SizedBox(height: 20,),
                  InputWithLabel(
                    label: 'Reciever Phone Number', 
                    hint: '000000000', 
                    prefix: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5,),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.asset('assets/images/photo.png', fit: BoxFit.cover,),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, size: 20,)
                          ],
                        ),
                        Text('+31', style: TextStyle(
                          color: AppColors.crow,
                          fontSize: 15
                        ),)
                      ],
                    ),
                    bigText: false, 
                    controller: textController
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: AppColors.green.withAlpha(100)
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.place_outlined, color: AppColors.green, size: 35,),
                      ),
                      SizedBox(width: 20,),
                      SizedBox(
                        width: 270,
                        child: Text('Provide the pickup location', style: TextStyle(
                          color: AppColors.crow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  InputWithLabel(
                    label: 'Enter Postcode', 
                    hint: '', 
                    bigText: false, 
                    controller: textController
                  ),
                  SizedBox(height: 35,),
                  InputWithLabel(
                    label: 'Street Address', 
                    hint: '', 
                    bigText: false, 
                    controller: textController
                  ),
                  SizedBox(height: 35,),
                  InputWithLabel(
                    label: 'Street Address 2 (Optional)', 
                    hint: '', 
                    bigText: false, 
                    controller: textController
                  ),
                  SizedBox(height: 35,),
                  InputWithLabel(
                    label: 'City / Town', 
                    hint: '', 
                    bigText: false, 
                    controller: textController
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withAlpha(100)
                        )
                      ]
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: GreenButton(
                      text: 'Next', 
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DatetimeScreen())
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}