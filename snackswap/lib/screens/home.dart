import 'package:flutter/material.dart';
import 'package:snackswap/constants/colors.dart';
import 'package:snackswap/screens/navigator.dart';
import 'package:snackswap/screens/profile.dart';
import 'package:snackswap/screens/search.dart';
import 'package:snackswap/screens/swaps.dart';

class HomeScreen extends StatefulWidget{
  final int page;
  const HomeScreen({this.page = 0, super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  late int _pageIndex;

  @override
  void initState(){
    super.initState();
    _pageIndex = widget.page;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            IndexedStack(
              index: _pageIndex,
              children: <Widget>[
                NavigatorScreen(
                  child: SearchScreen(),
                ),
                NavigatorScreen(
                  child: SwapsScreen(),
                ),
                NavigatorScreen(
                  child: ProfileScreen(),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
        // height: 70,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 40,
            fixedColor: AppColors.white,
            backgroundColor: _pageIndex == 2 ? AppColors.darkblue : AppColors.orange,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cookie),
                label: 'Swaps'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile'
              )
            ],
            currentIndex: _pageIndex,
            onTap: (int index){
              setState(() {
                _pageIndex = index;
              });
            },
          ),
        ),
      ),
            )
          ],
      ),
      // bottomNavigationBar: 
      );
    
  }
}