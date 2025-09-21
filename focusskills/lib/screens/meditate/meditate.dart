import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/screens/meditate/details.dart';
import 'package:focusskills/widgets/home/daily.dart';
import 'package:focusskills/widgets/sleep/tab.dart';

class MeditateScreen extends StatefulWidget{
  const MeditateScreen({super.key});

  @override
  State<MeditateScreen> createState() => _MeditateScreenState();
}

class _MeditateScreenState extends State<MeditateScreen> with TickerProviderStateMixin{
  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState(){
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 5, 
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Meditate', style: TextStyle(
                color: AppColors.color,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),),
              SizedBox(height: 10,),
              Text('We can learn how to recognize when our minds are doing their normal everyday acrobatics.', style: TextStyle(
                color: AppColors.color.withAlpha(100),
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
              background: tabIndex == 0 ? AppColors.purple : AppColors.grey, 
              color: tabIndex == 0 ? AppColors.color : AppColors.grey,
            ),
            SleepTab(
              label: 'My', 
              icon: 'assets/icons/heart_grey.svg', 
              background: tabIndex == 1 ? AppColors.purple : AppColors.grey, 
              color: tabIndex == 1 ? AppColors.color : AppColors.grey,
            ),
            SleepTab(
              label: 'Anxious', 
              icon: 'assets/icons/anxious_grey.svg', 
              background: tabIndex == 2 ? AppColors.purple : AppColors.grey, 
              color: tabIndex == 2 ? AppColors.color : AppColors.grey,
            ),
            SleepTab(
              label: 'Sleep', 
              icon: 'assets/icons/sleep_grey.svg', 
              background: tabIndex == 3 ? AppColors.purple : AppColors.grey, 
              color: tabIndex == 3 ? AppColors.color : AppColors.grey,
            ),
            SleepTab(
              label: 'Kids', 
              icon: 'assets/icons/kids_grey.svg', 
              background: tabIndex == 4 ? AppColors.purple : AppColors.grey, 
              color: tabIndex == 4 ? AppColors.color : AppColors.grey,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            HomeDaily(
              title: 'Daily Calm',
              subtitle: 'APR 30 · PAUSE PRACTICE',
              isLight: false,
              onTap: (){}
            ),
            SizedBox(height: 20,),
            Flexible(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 20,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => MeditateDetailsScreen(),)
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: SvgPicture.asset('assets/images/scenery_calm.svg'),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              child: Text('7 Days of Calm', style: TextStyle(
                                color: AppColors.lightcolor,
                                fontWeight: FontWeight.w800,
                                fontSize: 18
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },)
              ),
            )
          ],
        ),
      ),
    );
  }
}