import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';

class InputField extends StatelessWidget{
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final Icon suffix;
  final VoidCallback? onTap;
  final Color iconColor;

  const InputField({super.key, required this.hint, required this.isPassword, required this.controller, required this.suffix, this.onTap, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          controller: controller,
          style: TextStyle(
            fontSize: 14
          ),
          decoration: InputDecoration(
            fillColor: AppColors.inputgrey,
            filled: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.color.withAlpha(100),
              fontFamily: 'Roboto'
            ),
          ),
          obscureText: isPassword,
        ),
      ),
    );
  }
  
}