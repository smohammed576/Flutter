import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/constants/colors.dart';
import 'package:gym/models/member/member.dart';
import 'package:gym/screens/auth.dart';
import 'package:gym/screens/membership.dart';
import 'package:gym/screens/studios.dart';
import 'package:gym/screens/themes.dart';
import 'package:gym/widgets/card.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Member? member;
  String? theme;

  @override
  void initState() {
    super.initState();
    findMember();
    getTheme();
  }

  void getTheme() async {
    await Hive.openBox('theme');
    setState(() {
      theme = Hive.box('theme').get('color');
    });
  }

  void findMember() async {
    await Hive.openBox('auth');
    final auth = Hive.box('auth').get('username');
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);

    setState(() {
      member = Member.fromJson(data['users'][auth]);
    });
  }

  void signout(BuildContext context) async {
    await Hive.box('auth').delete('username');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThemesScreen()),
              );
            },
            icon: Icon(
              Icons.color_lens,
              color: AppColors.appColors[theme],
              size: 30,
            ),
          ),
        ],
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Icon.png',
                color: theme != 'green' ? BlendColors.blendColors[theme] : null,
                colorBlendMode: BlendMode.color,
              ),
              SizedBox(width: 10),
              Text(
                'VierToreGym',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appColors[theme],
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hi, ${member?.firstname}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    side: BorderSide(
                      color: AppColors.appColors[theme] ?? Colors.green,
                      width: 3,
                    ),
                  ),
                  onPressed: () {
                    signout(context);
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.appColors[theme],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Center(
              widthFactor: double.infinity,
              child: Column(
                children: [
                  HomeCard(
                    name: 'Membership',
                    icon: 'User attributes.png',
                    theme: theme!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MembershipScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  HomeCard(
                    name: 'Studios',
                    icon: 'Location on.png',
                    theme: theme!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudiosScreen(),
                          // builder: (context) => ThemesScreen()
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
