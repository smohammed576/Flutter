import 'package:flutter/material.dart';
import 'package:packages/constants/colors.dart';

class InputField extends StatelessWidget{
  final String label;
  final bool isPassword;
  final TextEditingController controller;

  const InputField({super.key, required this.label, required this.isPassword, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: AppColors.color
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.color, width: 0.4)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.color, width: 0.4)),
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.yellow
          )
        ),
        obscureText: isPassword,
      ),
    );
  }
}