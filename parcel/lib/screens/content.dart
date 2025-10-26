import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/screens/example.dart';
import 'package:parcel/widgets/appbar.dart';
import 'package:parcel/widgets/greenbutton.dart';
import 'package:parcel/widgets/input.dart';

class ContentScreen extends StatefulWidget{
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
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
                Text('What is in the package?', style: TextStyle(
                  color: AppColors.crow,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 20,),
                InputWithLabel(
                  label: 'What is in the package?', 
                  hint: '', 
                  bigText: false,
                  controller: textController
                ),
                SizedBox(height: 30,),
                InputWithLabel(
                  label: 'Additional Note (Optional)', 
                  hint: 'Is it breakable?', 
                  bigText: true,
                  controller: noteController
                )
              ],
            ),
            GreenButton(
              text: 'Next', 
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExampleScreen())
              )
            )
          ],
        ),
      ),
    );
  }
}