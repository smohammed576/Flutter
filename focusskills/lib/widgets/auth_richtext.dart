import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';

class AuthRichText extends StatelessWidget{
  final VoidCallback onTap;
  const AuthRichText({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'ALREADY HAVE AN ACCOUNT?',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: AppColors.color.withAlpha(120),
              fontWeight: FontWeight.w500,
              fontSize: 12
            )
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: SizedBox(
              width: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: onTap,
                child: Text('LOG IN', style: TextStyle(
                  fontFamily: 'Roboto',
                  color: AppColors.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 12
                )
              )
              ),
            )
          )
        ]
      ),
    );
  }
}