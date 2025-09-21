import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/topic.dart';

class TopicsItem extends StatelessWidget{
  final Topic topic;
  final bool isLarge;
  final VoidCallback onTap;

  const TopicsItem({super.key, required this.topic, required this.isLarge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.45,
        height: isLarge ? 225 : 180,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColors.topics[topic.colors[0]],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(topic.image)
              ),
              SizedBox(height: isLarge ? 40 : 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(topic.title, style: TextStyle(
                  color: AppColors.topics[topic.colors[1]],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.1
                ),
                  overflow: TextOverflow.visible,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}