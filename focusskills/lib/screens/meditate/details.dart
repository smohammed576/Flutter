import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/screens/results/play.dart';
import 'package:focusskills/widgets/leadingbutton.dart';
import 'package:focusskills/widgets/sleep/opacitybutton.dart';
import 'package:hive/hive.dart';

class MeditateDetailsScreen extends StatefulWidget{
  const MeditateDetailsScreen({super.key});

  @override
  State<MeditateDetailsScreen> createState() => _MeditateDetailsScreenState();
}

class _MeditateDetailsScreenState extends State<MeditateDetailsScreen> with TickerProviderStateMixin{
  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState(){
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2, 
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () async {
              await Hive.box('newuser').put('isWelcomed', false);
            }
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
          SvgPicture.asset('assets/images/sunrise.svg', width: MediaQuery.sizeOf(context).width,),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Happy Morning', style: TextStyle(
                color: AppColors.color,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),),
              SizedBox(height: 15,),
              Text('COURSE', style: TextStyle(
                color: AppColors.color.withAlpha(150),
                fontWeight: FontWeight.w600,
                fontSize: 14
              ),),
              SizedBox(height: 15,),
              Text("Ease the mind into a restful night’s sleep with these deep, amblent tones.", style: TextStyle(
                color: AppColors.color.withAlpha(200),
                fontSize: 14,
                fontWeight: FontWeight.w300
              ),),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  children: [
                    Wrap(
                      children: [
                        SvgPicture.asset('assets/icons/heart_red.svg',),
                        SizedBox(width: 10,),
                        Text('24.234 Favorites', style: TextStyle(
                          color: AppColors.color.withAlpha(140),
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                        ),)
                      ],
                    ),
                    SizedBox(width: 20,),
                    Wrap(
                      children: [
                        SvgPicture.asset('assets/icons/headphones_blue.svg',),
                        SizedBox(width: 10,),
                        Text('34.234 Listening', style: TextStyle(
                          color: AppColors.color.withAlpha(140),
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                        ),)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text('Pick a narrator', style: TextStyle(
                color: AppColors.color,
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),)
            ])
          ),
          TabBar(
            controller: tabController,
            labelColor: AppColors.purple,
            indicatorColor: AppColors.purple,
            indicatorWeight: 0.8,
            unselectedLabelColor: AppColors.color.withAlpha(100),
            tabs: [
              Text('MALE VOICE'),
              Text('FEMALE VOICE')
            ],
          ),
          Column(
            children: List.generate(3, (index) {
              return ListTile(
                leading: SizedBox(
                  width: 35,
                  height: 35,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: index == 0 ? AppColors.purple : null,
                      side: index == 0 ? null : BorderSide(color: AppColors.color, width: 0.2),
                      padding: EdgeInsets.zero
                    ),
                    onPressed: () async {
                      await Hive.box('music').put('track', 'Focus Attention');
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlayScreen(
                        title: 'Focus Attention', 
                        subtitle: '7 DAYS OF CALM', 
                        isLight: true
                      ),)
                    );
                    },
                    icon: Icon(Icons.play_arrow_rounded, color: index == 0 ? AppColors.lightcolor : AppColors.color.withAlpha(150), size: 20,),
                  ),
                ),
                title: Text('Focus Attention', style: TextStyle(
                  color: AppColors.color,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
                ),),
                subtitle: Text('10 MIN', style: TextStyle(
                  color: AppColors.color.withAlpha(150),
                  fontWeight: FontWeight.w500,
                  fontSize: 12
                ),),
              );
            },)
          )
        ],
      ),
    );
  }
}