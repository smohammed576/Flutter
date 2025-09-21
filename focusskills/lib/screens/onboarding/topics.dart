import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/topic.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/screens/onboarding/reminders.dart';
import 'package:focusskills/widgets/topics/topic.dart';
import 'package:hive_flutter/adapters.dart';

class TopicsScreen extends StatefulWidget{
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  List<Topic>? topics;
  String? topic;

  @override
  void initState(){
    super.initState();
    getTopics();
  }

  void getTopics() async{
    final String response = await rootBundle.loadString('assets/data/topics.json');
    final List data = json.decode(response);
    final List<Topic> results = data.map((item) => Topic.fromJson(item)).toList();
    setState(() {
      topics = results;
    });
  }

  void addTopic(String title) async{
    final auth = Hive.box('auth').get('id');
    final user = Hive.box<User>('users').values.firstWhere((item) => item.id == auth);
    user.focus = title;
    await user.save();
    setState(() {
      topic = title;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RemindersScreen(),)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: SvgPicture.asset('assets/backgrounds/topics_background.svg'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('What brings you', style: TextStyle(
                    color: AppColors.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),),
                  Text('to Focus Skills?', style: TextStyle(
                    color: AppColors.color,
                    fontWeight: FontWeight.w200,
                    fontSize: 25
                  ),),
                  SizedBox(height: 10,),
                  Text('choose a topic to focus on:', style: TextStyle(
                    color: AppColors.color.withAlpha(150),
                    fontWeight: FontWeight.w200,
                    fontSize: 16
                  ),),
                  SizedBox(height: 15,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: topics != null && topics!.isNotEmpty ? [
                      Column(
                        children: List.generate(3, (index) => TopicsItem(
                          topic: topics![index],
                          isLarge: topics![index].isLarge, 
                          onTap: () => addTopic(topics![index].title)
                        ))
                      ),
                      Column(
                        children: List.generate(3, (index) => TopicsItem(
                          topic: topics![index + 3],
                          isLarge: topics![index + 3].isLarge, 
                          onTap: () => addTopic(topics![index + 3].title)
                        ))
                      )
                    ] : []
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}