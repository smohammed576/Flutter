import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/sleep.dart';
import 'package:focusskills/screens/results/play.dart';
import 'package:focusskills/widgets/leadingbutton.dart';
import 'package:focusskills/widgets/sleep/option.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SleepMusicScreen extends StatelessWidget{
  final List<Sleep> data;
  const SleepMusicScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkblue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 80,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: LeadingButton(
            isClose: false,
            hasOutline: true,
            onTap: () => Navigator.of(context).pop()
          ),
        ),
        title: Text('Sleep Music', style: TextStyle(
          color: AppColors.lightcolor,
          fontWeight: FontWeight.bold,
          fontSize: 22
        ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Flexible(
          child: GridView.count(
            shrinkWrap: false,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: List.generate(data.length, (index) => SleepOption(
              title: data[index].title, 
              image: data[index].image, 
              onTap: () async{
                await Hive.box('music').put('track', data[index].title);
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (context) => PlayScreen(title: data[index].title, subtitle: data[index].subtitle, isLight: false),)
                );
              }
            ))
          ),
        ),
      ),
    );
  }
}