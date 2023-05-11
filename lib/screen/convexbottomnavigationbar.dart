import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConvexBottomNavigationBar extends StatefulWidget {
  @override
  State<ConvexBottomNavigationBar> createState() =>
      _ConvexBottomNavigationBarState();
}

class _ConvexBottomNavigationBarState extends State<ConvexBottomNavigationBar> {
  int index = 0;
  List<Icon> listOfIcons = [
    Icon(Icons.car_rental),
    Icon(Icons.alarm),
    Icon(Icons.cake)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Nav Bar"),
      ),
      body: Center(child: listOfIcons[index]),
    );
  }
}
