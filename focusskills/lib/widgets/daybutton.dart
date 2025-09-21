import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';

class RemindersDayButton extends StatefulWidget{
  final String day;
  final bool isActive;
  final VoidCallback onTap;
  const RemindersDayButton({super.key, required this.day, required this.isActive, required this.onTap});

  @override
  State<RemindersDayButton> createState() => _RemindersDayButtonState();
}

class _RemindersDayButtonState extends State<RemindersDayButton> {
  bool? isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isChecked! ? AppColors.color : null,
          padding: EdgeInsets.zero,
          side: BorderSide(color: AppColors.color.withAlpha(100))
        ),
        onPressed: (){
          setState(() {
            isChecked = !isChecked!;
          });
          widget.onTap();
        }, 
        child: Text(widget.day, style: TextStyle(
          color: isChecked! ? AppColors.lightcolor : AppColors.color.withAlpha(150)
        ),)
      ),
    );
  }
}