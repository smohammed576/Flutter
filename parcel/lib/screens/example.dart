import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/screens/delivery.dart';
import 'package:parcel/widgets/appbar.dart';
import 'package:parcel/widgets/example.dart';
import 'package:parcel/widgets/greenbutton.dart';

class ExampleScreen extends StatefulWidget{
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  bool pictureTaken = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 50), 
        child: ParcelAppBar()
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Take a picture of the item', style: TextStyle(
                  color: AppColors.crow,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 20,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Please note: ', style: TextStyle(
                          color: AppColors.crow,
                          fontFamily: 'Geist',
                          fontWeight: FontWeight.bold
                        )
                      ),
                      TextSpan(
                        text: 'Take picture of your parcel close to a recognisable object such as a chair, pen, etc.', style: TextStyle(
                          color: AppColors.crow,
                          fontFamily: 'Geist',
                        )
                      )
                    ]
                  ),
                ),
                SizedBox(height: 40,),
                Column(
                  children: pictureTaken ? [
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/images/photo.png', fit: BoxFit.cover,),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: CircleBorder(),
                              side: BorderSide(color: AppColors.bordergreen),
                              backgroundColor: AppColors.black
                            ),
                            onPressed: () {
                              setState(() {
                                pictureTaken = !pictureTaken;
                              });
                            },
                            child: Icon(Icons.close, color: AppColors.white,),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                        ),
                        onPressed: (){},
                        child: Text('Take another picture', style: TextStyle(
                          color: AppColors.crow
                        ),),
                      ),
                    )
                  ] : [
                    Example(
                      image: 'image', 
                      number: 1
                    ),
                    SizedBox(height: 30,),
                    Example(
                      image: 'image', 
                      number: 2
                    ),
                    SizedBox(height: 20,),
                    Text('If you do not follow this instruction, your order request will not be valid', style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.bold
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
            GreenButton(
              text: pictureTaken ? 'Submit' : 'Take a Picture', 
              icon: pictureTaken ? null : Icons.camera_alt_outlined,
              onTap: (){
                if(pictureTaken){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeliveryScreen())
                  );
                }
                else{
                  setState(() {
                    pictureTaken = !pictureTaken;
                  });
                }
              }
            )
          ],
        ),
      ),
    );
  }
}