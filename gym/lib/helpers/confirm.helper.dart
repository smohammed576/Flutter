import 'package:flutter/material.dart';
import 'package:gym/constants/colors.dart';

Future<void> dialogBuilder(BuildContext context, theme) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Updated!", textAlign: TextAlign.center),
        content: Text('Changes has been whatever', textAlign: TextAlign.center),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appColors[theme],
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Ok',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}
