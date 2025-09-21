import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/routes/navigator.dart';
import 'package:focusskills/widgets/purplebutton.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SleepWelcomeScreen extends StatefulWidget{
  const SleepWelcomeScreen({super.key});

  @override
  State<SleepWelcomeScreen> createState() => _SleepWelcomeScreenState();
}

class _SleepWelcomeScreenState extends State<SleepWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkblue,
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset('assets/backgrounds/nightsmoke.svg'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 85),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Welcome to Sleep', style: TextStyle(
                        color: AppColors.lightcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                      ),),
                      SizedBox(height: 20,),
                      Text('Explore the new king of sleep. It uses sound and visualisation to create perfect conditions for refreshing sleep.', style: TextStyle(
                        color: AppColors.lightcolor,
                        fontSize: 14
                      ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset('assets/images/birds.svg', width: MediaQuery.sizeOf(context).width,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: PurpleButton(
                    text: 'GET STARTED', 
                    isNotPurple: false,
                    onTap: () async{
                      await Hive.box('newuser').put('isWelcomed', true);
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainNavigator(page: 1, user: Hive.box<User>('users').values.firstWhere((item) => item.id == Hive.box('auth').get('id')),))
                    );
                    }
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