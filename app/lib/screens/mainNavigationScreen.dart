import 'package:app/screens/createTripScreen.dart';
import 'package:app/screens/homeScreen.dart';
import 'package:app/screens/profileScreen.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {

  int _index = 0;

  final tabs = [
    HomeScreen(),
    CreateTripScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_index],
      bottomNavigationBar: createNavigation(),
    );
  }

  createNavigation(){
    return BottomNavigationBar(
      items: const  <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_sharp), label: 'Create a Trip'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
      currentIndex: _index,
      selectedItemColor: Colors.amber[800],
      selectedIconTheme: const IconThemeData(size: 35),
      unselectedIconTheme: const IconThemeData(size: 30),
      showUnselectedLabels: false,
      showSelectedLabels: true,
      onTap: _onItemTapped,
    );
  }



}
