import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _index = 0;

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_sharp), label: 'Create a Trip'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        elevation: 0,
        currentIndex: _index,
        selectedItemColor: Colors.amber[800],
        selectedIconTheme: const IconThemeData(size: 60),
        unselectedIconTheme: const IconThemeData(size: 40),
        showUnselectedLabels: false,
        showSelectedLabels: true,
        onTap: _onItemTapped,
      ),
      );
  }
}
