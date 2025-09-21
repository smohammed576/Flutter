import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/sleep.dart';
import 'package:focusskills/screens/results/play.dart';
import 'package:focusskills/widgets/leadingbutton.dart';
import 'package:focusskills/widgets/purplebutton.dart';
import 'package:focusskills/widgets/sleep/opacitybutton.dart';
import 'package:focusskills/widgets/sleep/option.dart';

class SleepOptionScreen extends StatelessWidget{
  final Sleep item;
  const SleepOptionScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkblue,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 80,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: LeadingButton(
            isClose: false,
            hasOutline: true, 
            onTap: () => Navigator.of(context).pop()
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
        actions: [
          OpacityButton(
            icon: 'assets/icons/heart_white.svg', 
            onTap: (){}
          ),
          SizedBox(width: 10,),
          OpacityButton(
            icon: 'assets/icons/download_white.svg', 
            onTap: (){}
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(item.image, width: MediaQuery.sizeOf(context).width,),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: TextStyle(
                color: AppColors.lightcolor,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),),
              SizedBox(height: 15,),
              Text('45 MIN · ${item.subtitle}', style: TextStyle(
                color: AppColors.lightcolor.withAlpha(150),
                fontWeight: FontWeight.w600,
                fontSize: 14
              ),),
              SizedBox(height: 15,),
              Text("Ease the mind into a restful night’s sleep with these deep, amblent tones.", style: TextStyle(
                color: AppColors.lightcolor.withAlpha(200),
                fontSize: 14,
                fontWeight: FontWeight.w300
              ),),
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.1, color: AppColors.lightcolor))
                ),
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  children: [
                    Wrap(
                      children: [
                        SvgPicture.asset('assets/icons/heart_red.svg', colorFilter: ColorFilter.mode(AppColors.lightcolor, BlendMode.srcIn),),
                        SizedBox(width: 10,),
                        Text('24.234 Favorites', style: TextStyle(
                          color: AppColors.lightcolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                        ),)
                      ],
                    ),
                    SizedBox(width: 20,),
                    Wrap(
                      children: [
                        SvgPicture.asset('assets/icons/headphones_blue.svg', colorFilter: ColorFilter.mode(AppColors.lightcolor, BlendMode.srcIn),),
                        SizedBox(width: 10,),
                        Text('34.234 Listening', style: TextStyle(
                          color: AppColors.lightcolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                        ),)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text('Related', style: TextStyle(
                color: AppColors.lightcolor,
                fontSize: 22,
                fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(2, (index) => SleepOption(
                  title: 'Moon Clouds', 
                  image: 'assets/images/cloudmoon.svg', 
                  onTap: (){}
                ),
              )
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.bottomCenter,
                child: PurpleButton(
                  text: 'PLAY', 
                  isNotPurple: false,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlayScreen(
                      title: item.title,
                      subtitle: item.subtitle,
                      isLight: false,
                    ),)
                  )
                ),
              )
              ],
            ),
          )
        ],
      ),
    );
  }
}