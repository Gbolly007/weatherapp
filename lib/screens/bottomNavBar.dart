import 'package:flutter/material.dart';
import 'package:weather_app/screens/searchForecast.dart';
import 'package:weather_app/screens/searchToday.dart';

import '../constants.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    SearchToday(),
    SearchForecast(),
    SearchForecast(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: todayText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wysiwyg_outlined),
            label: weeklyText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: shareText,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: activecolor,
        onTap: _onItemTapped,
      ),
    );
  }
}
