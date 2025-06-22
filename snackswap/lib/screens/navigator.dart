import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget{
  const NavigatorScreen({required this.child, super.key});

  final Widget child;

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => widget.child
        );
      },
    );
  }
}