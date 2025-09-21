import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/helpers/time.helper.dart';
import 'package:focusskills/models/topic.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/screens/auth/auth.dart';
import 'package:focusskills/widgets/daybutton.dart';
import 'package:focusskills/widgets/logout.dart';
import 'package:focusskills/widgets/topics/topic.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
  User? user;
  Topic? topic;

  @override
  void initState(){
    super.initState();
    getUser();
    getTopic();
  }

  void getUser() async{
    final auth = Hive.box('auth').get('id');
    final findUser = Hive.box<User>('users').values.firstWhere((item) => item.id == auth);
    setState(() {
      user = findUser;
    });
  }

  void getTopic() async{
    final auth = Hive.box('auth').get('id');
    final findUser = Hive.box<User>('users').values.firstWhere((item) => item.id == auth);
    final String response = await rootBundle.loadString('assets/data/topics.json');
    final List data = json.decode(response);
    final findTopic = data.firstWhere((item) => item["title"] == findUser.focus);
    setState(() {
      topic = Topic.fromJson(findTopic);
    });
  }

  String formatTime(time){
    return DateFormat.Hm().format(time);
  }

  void signout() async{
    await Hive.box('auth').delete('id');
    setState(() {
      user = null;
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => AuthScreen(),)
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset('assets/images/logo_dark.svg'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: user != null && topic != null ? Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: AppColors.darkblue
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(user!.name, style: TextStyle(
              color: AppColors.color,
              fontWeight: FontWeight.bold,
              fontSize: 28
            ),),
            Text(user!.email, style: TextStyle(
              color: AppColors.color.withAlpha(150),
              fontSize: 16
            ),),
            SizedBox(height: 10,),
            LogoutButton(
              onTap: () => signout(),
            ),
            SizedBox(height: 20,),
            TopicsItem(
              topic: topic!,
              isLarge: false, 
              onTap: (){}
            ),
            SizedBox(height: 20,),
            Text('Reminders', style: TextStyle(
              color: AppColors.color,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(formatTime(user!.time!), style: TextStyle(
                  color: AppColors.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),),
                SizedBox(width: 10,),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero
                  ),
                  onPressed: () async{
                    final getTime = await buildBottomSheet(context, user!.time!);
                    if(getTime != null){
                      user!.time = getTime;
                      await user!.save();
                      getUser();
                    }
                  },
                  child: Text('Change?', style: TextStyle(
                    color: AppColors.purple,
                    fontWeight: FontWeight.bold
                  ),),
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(days.length, (index) => RemindersDayButton(
                day: days[index], 
                isActive: user!.days!.contains(index), 
                onTap: () async{
                  if(user!.days!.contains(index)){
                    user!.days = List.from(user!.days!)..remove(index);
                  }
                  else{
                    user!.days = List.from(user!.days!)..add(index);
                  }
                  await user!.save();
                }
              ),)
            )
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}