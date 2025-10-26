import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/models/type.dart';
import 'package:parcel/screens/content.dart';
import 'package:parcel/widgets/appbar.dart';
import 'package:parcel/widgets/greenbutton.dart';
import 'package:parcel/widgets/input.dart';

class SizeScreen extends StatefulWidget{
  final Type type;
  const SizeScreen({super.key, required this.type});

  @override
  State<SizeScreen> createState() => _SizeScreenState();
}

class _SizeScreenState extends State<SizeScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 50),
        child: ParcelAppBar()
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Provide more details about your ${widget.type.label.toLowerCase()}', style: TextStyle(
                  color: AppColors.crow,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 20,),
                InputWithLabel(
                  label: 'Height of Package', 
                  hint: 'Height in cm', 
                  prefix: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('cm', style: TextStyle(
                        color: AppColors.crow,
                        fontSize: 14
                      ),),
                      SizedBox(width: 10,),
                      Icon(Icons.keyboard_arrow_down, size: 20,)
                    ],
                  ),
                  bigText: false,
                  controller: heightController
                ),
                SizedBox(height: 20,),
                InputWithLabel(
                  label: 'Width of Package', 
                  hint: 'Width in cm', 
                  prefix: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('cm', style: TextStyle(
                        color: AppColors.crow,
                        fontSize: 14
                      ),),
                      SizedBox(width: 10,),
                      Icon(Icons.keyboard_arrow_down, size: 20,)
                    ],
                  ),
                  bigText: false,
                  controller: widthController
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(
                      width: 250,
                      child: InputWithLabel(
                        label: 'Weight of Package', 
                        hint: 'Weight', 
                        prefix: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('g', style: TextStyle(
                              color: AppColors.crow,
                              fontSize: 14
                            ),),
                            SizedBox(width: 10,),
                            Icon(Icons.keyboard_arrow_down, size: 20,)
                          ],
                        ),
                        bigText: false,
                        controller: widthController
                      ),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      width: 90,
                      child: InputWithLabel(
                        label: 'Quantity', 
                        hint: '',
                        bigText: false,
                        controller: widthController
                      ),
                    ),
                  ],
                )
              ],
            ),
            GreenButton(
              text: 'Next', 
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContentScreen())
              )
            )
          ],
        ),
      ),
    );
  }
}