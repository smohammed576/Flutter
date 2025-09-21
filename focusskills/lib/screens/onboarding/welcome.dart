import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/screens/onboarding/topics.dart';
import 'package:focusskills/widgets/purplebutton.dart';

class WelcomeScreen extends StatefulWidget{
  final User user;
  const WelcomeScreen({super.key, required this.user});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset('assets/images/logo_light.svg'),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SvgPicture.asset('assets/backgrounds/onboarding.svg'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hi ${widget.user.name},', style: TextStyle(
                      color: AppColors.beigeyellow,
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                    ),),
                    Text('Welcome to Focus Skills', style: TextStyle(
                      color: AppColors.beigeyellow,
                      fontWeight: FontWeight.w200,
                      fontSize: 26
                    ),),
                    SizedBox(height: 15,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Explore the app and find some peace of mind to prepare for meditation', style: TextStyle(
                        color: AppColors.lightcolor,
                        fontSize: 16,
                      ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                PurpleButton(
                  text: 'GET STARTED', 
                  isNotPurple: true, 
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TopicsScreen(),)
                  )
                )
              ],
            ),
          )
        ],
      ), 
    );
  }
}