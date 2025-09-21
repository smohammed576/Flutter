import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/sleep.dart';
import 'package:focusskills/screens/sleep/option.dart';
import 'package:focusskills/screens/sleep/music.dart';
import 'package:focusskills/widgets/sleep/option.dart';
import 'package:focusskills/widgets/sleep/tab.dart';

class SleepScreen extends StatefulWidget{
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> with TickerProviderStateMixin{
  late TabController tabController;
  int tabIndex = 0;
  List<Sleep>? data;

  @override
  void initState(){
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 5, 
      vsync: this
    );
    getData();
  }

  void getData() async{
    final String response = await rootBundle.loadString('assets/data/sleep.json');
    final List results = json.decode(response);
    setState(() {
      data = results.map((item) => Sleep.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkblue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        backgroundColor: Colors.transparent,
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: 0,
              child: SvgPicture.asset('assets/backgrounds/sleep_background.svg'),
            )
          ],
        ),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Sleep Stories', style: TextStyle(
                color: AppColors.lightcolor,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),),
              SizedBox(height: 10,),
              Text('Soothing bedtime stories to help you fall into a deep and natural sleep', style: TextStyle(
                color: AppColors.lightcolor,
                fontSize: 14
              ),
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.visible,
              )
            ],
          ),
        ),        
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          dividerHeight: 0,
          indicatorPadding: EdgeInsets.zero,
          indicator: BoxDecoration(
            border: null
          ),
          tabAlignment: TabAlignment.start,
          onTap: (value) {
            setState(() {
              tabIndex = value;
            });
          },
          tabs: [
            SleepTab(
              label: 'All', 
              icon: 'assets/icons/all_grey.svg', 
              background: tabIndex == 0 ? AppColors.purple : AppColors.bluegrey, 
              color: AppColors.lightcolor,
            ),
            SleepTab(
              label: 'My', 
              icon: 'assets/icons/heart_grey.svg', 
              background: tabIndex == 1 ? AppColors.purple : AppColors.bluegrey, 
              color: AppColors.lightcolor,
            ),
            SleepTab(
              label: 'Anxious', 
              icon: 'assets/icons/anxious_grey.svg', 
              background: tabIndex == 2 ? AppColors.purple : AppColors.bluegrey, 
              color: AppColors.lightcolor,
            ),
            SleepTab(
              label: 'Sleep', 
              icon: 'assets/icons/sleep_grey.svg', 
              background: tabIndex == 3 ? AppColors.purple : AppColors.bluegrey, 
              color: AppColors.lightcolor,
            ),
            SleepTab(
              label: 'Kids', 
              icon: 'assets/icons/kids_grey.svg', 
              background: tabIndex == 4 ? AppColors.purple : AppColors.bluegrey, 
              color: AppColors.lightcolor,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.purple
                ),
                width: MediaQuery.sizeOf(context).width,
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('The Ocean Moon', style: TextStyle(
                      color: AppColors.beigeyellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),),
                    Text('Non-stop 8-hour mixes of our most popular sleep audio', style: TextStyle(
                      color: AppColors.lightcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w200
                    ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 80,
                      height: 38,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          elevation: 0
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SleepMusicScreen(data: data!,))
                        ),
                        child: Text('START', style: TextStyle(
                          color: AppColors.color
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              if(data != null && data!.isNotEmpty)
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 20,
                  children: List.generate(data!.length, (index) {
                    return SleepOption(
                      title: data![index].title, 
                      image: data![index].image, 
                      onTap: () => Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => SleepOptionScreen(item: data![index]),)
                      )
                    );
                  },)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}