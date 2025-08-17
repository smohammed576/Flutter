import 'package:flutter/material.dart';
import 'package:smoothie/constants/colors.dart';

class OptionButton extends StatefulWidget{
  final String text;
  final bool isChosen;
  final VoidCallback onTap;
  const OptionButton({super.key, required this.text, required this.isChosen, required this.onTap});

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  bool? isChecked;

  @override
  void initState(){
    super.initState();
    isChecked = widget.isChosen;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked!;
        });
        widget.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.orange, width: 2),
          borderRadius: BorderRadius.circular(5)
        ),
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.text, style: TextStyle(
              color: AppColors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 22
            ),),
            if(isChecked!)
            Icon(Icons.check, color: AppColors.green, weight: 800, size: 30,)
          ],
        ),
      ),
    );
  }
}