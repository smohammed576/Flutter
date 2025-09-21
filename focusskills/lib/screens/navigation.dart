import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget{
  final Widget child;
  const NavigationScreen({super.key, required this.child});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => widget.child,
        );
      },
    );
  }
}