import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/widgets/home/daily.dart';
import 'package:focusskills/widgets/home/recommended.dart';
import 'package:focusskills/widgets/home/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;

  @override
  void initState(){
    super.initState();
    getUser();
  }

  void getUser(){
    final auth = Hive.box('auth').get('id');
    final findUser = Hive.box<User>('users').values.firstWhere((item) => item.id == auth);
    setState(() {
      user = findUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset('assets/images/logo_dark.svg'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good Morning, ${user!.name}', style: TextStyle(
                    color: AppColors.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 28
                  ),),
                  SizedBox(height: 5,),
                  Text('We wish you a good day', style: TextStyle(
                    color: AppColors.color.withAlpha(150),
                    fontWeight: FontWeight.w200,
                    fontSize: 18
                  ),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeTask(
                        name: 'Basics', 
                        type: 'COURSE', 
                        colors: [AppColors.purple, AppColors.beigeyellow], 
                        image: 'assets/images/appleheart.svg', 
                        isLight: true, 
                        onTap: (){}
                      ),
                      HomeTask(
                        name: 'Relaxation', 
                        type: 'MUSIC', 
                        colors: [AppColors.orangeyellow, AppColors.color], 
                        image: 'assets/images/orangemusic.svg', 
                        isLight: false, 
                        onTap: (){}
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  HomeDaily(
                    title: 'Daily Thought',
                    subtitle: 'MEDITATION · 3-10 MIN',
                    isLight: true,
                    onTap: (){}
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recommended for you', style: TextStyle(
                    color: AppColors.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 24
                  ),),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 300,
                    child: Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return HomeRecommended(
                            title: 'Focus', 
                            color: AppColors.lightgreen, 
                            image: 'assets/images/focus.svg', 
                            onTap: (){}
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 200,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}