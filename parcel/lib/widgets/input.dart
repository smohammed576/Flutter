import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';

class InputWithLabel extends StatelessWidget{
  final String label;
  final String hint;
  final Widget? prefix;
  final bool bigText;
  final TextEditingController controller;
  const InputWithLabel({super.key, required this.label, required this.hint, this.prefix, required this.bigText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(
          color: AppColors.crow,
          fontSize: 14
        ),),
        SizedBox(height: 10,),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: AppColors.lightgrey,
              filled: true,
              border: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.bordergreen), borderRadius: BorderRadius.circular(5)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.bordergreen), borderRadius: BorderRadius.circular(5)),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.bordergreen), borderRadius: BorderRadius.circular(5)),
              prefixIcon: prefix,
              prefixIconConstraints: prefix != null ? BoxConstraints(maxWidth: 100, maxHeight: 40) : null,
              hint: bigText ? Text(hint, style: TextStyle(
                  color: AppColors.crow.withAlpha(60),
                  fontSize: 14
                ),) : Center(
                child: Text(hint, style: TextStyle(
                  color: AppColors.crow.withAlpha(60),
                  fontSize: 14
                ),),
              ),
            ),
            minLines: bigText ? 10 : null,
            maxLines: bigText ? 11 : null,
          ),
        )
      ],
    );
  }
}