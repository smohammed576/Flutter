import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/screens/home.dart';
import 'package:focusskills/screens/meditate/meditate.dart';
import 'package:focusskills/screens/navigation.dart';
import 'package:focusskills/screens/profile/profile.dart';
import 'package:focusskills/screens/results/play.dart';
import 'package:focusskills/screens/sleep/sleep.dart';
import 'package:focusskills/screens/sleep/welcome.dart';
import 'package:hive/hive.dart';

class MainNavigator extends StatefulWidget{
  final int page;
  final User user;
  const MainNavigator({super.key, this.page = 0, required this.user});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int? pageIndex;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: pageIndex,
            children: [
              NavigationScreen(
                child: HomeScreen(),
              ),
              NavigationScreen(
                child: SleepScreen(),
              ),
              NavigationScreen(
                child: MeditateScreen(),
              ),
              NavigationScreen(
                child: HomeScreen(),
              ),
              NavigationScreen(
                child: ProfileScreen(),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              elevation: 50,
              backgroundColor: pageIndex == 1 ? AppColors.darkblue : AppColors.white,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: pageIndex == 1 ? AppColors.white : AppColors.purple,
              unselectedItemColor: AppColors.grey,
              selectedFontSize: 12,
              currentIndex: pageIndex!,
              onTap: (value) {
                if(value == 3){
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => PlayScreen(title: 'Meditation Music', subtitle: 'MUSIC', isLight: true),)
                  );
                }
                else{
                  if(value == 1){
                    final newuser = Hive.box('newuser');
                    bool isNew = newuser.get('isWelcomed', defaultValue: false);
                    if(!isNew){
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => SleepWelcomeScreen(),)
                      );
                    }
                  }
                  setState(() {
                    pageIndex = value;
                  });
                }
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: pageIndex == 0 ? AppColors.purple : null,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/icons/home_grey.svg', colorFilter: pageIndex == 0 ? ColorFilter.mode(AppColors.white, BlendMode.srcIn) : null)
                  ),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: pageIndex == 1 ? AppColors.purple : null,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/icons/moon_grey.svg', colorFilter: pageIndex == 1 ? ColorFilter.mode(AppColors.white, BlendMode.srcIn) : null)
                  ),
                  label: 'Sleep'
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: pageIndex == 2 ? AppColors.purple : null,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/icons/stones_grey.svg', colorFilter: pageIndex == 2 ? ColorFilter.mode(AppColors.white, BlendMode.srcIn) : null)
                  ),
                  label: 'Meditate'
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: pageIndex == 3 ? AppColors.purple : null,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/icons/music_grey.svg', colorFilter: pageIndex == 3 ? ColorFilter.mode(AppColors.white, BlendMode.srcIn) : null)
                  ),
                  label: 'Music'
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: pageIndex == 4 ? AppColors.purple : null,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/icons/person_grey.svg', colorFilter: pageIndex == 4 ? ColorFilter.mode(AppColors.white, BlendMode.srcIn) : null,)
                  ),
                  label: widget.user.name
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}