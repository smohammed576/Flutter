import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/widgets/purplebutton.dart';

Future buildBottomSheet(BuildContext context, DateTime time) async {
  DateTime pickTime = time;
  return showModalBottomSheet(
    backgroundColor: AppColors.white,
    context: context, 
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                initialDateTime: time,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) {
                  pickTime = value;
                },
              ),
            ),
            SizedBox(height: 20,),
            PurpleButton(
              text: 'SAVE', 
              isNotPurple: false, 
              onTap: () => Navigator.of(context).pop(pickTime)
            )
          ],
        ),
      );
    },
  );
}