import 'package:app/firebaseHandler.dart';
import 'package:app/screens/createTripScreen.dart';
import 'package:app/screens/homeScreen.dart';
import 'package:app/screens/profileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../assets/Colors.dart';

class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({Key? key, required this.index}) : super(key: key);

  int index = 0;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {

  int _index = 0;
  String? mtoken = " ";
  FirebaseHandler handler = FirebaseHandler();

  @override
  void initState(){
    super.initState();
    _index = widget.index;


    requestPermissions();
    getToken();

  }

  requestPermissions() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User permissions granted");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("Provitional permissions granted");
    } else {
      print("User permissions denied");
    }
  }

  getToken() async{
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("Token is $mtoken");
      });
      handler.saveToken(token!);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: navigateToScreen(),
      bottomNavigationBar: createNavigation(),
    );
  }

  Widget navigateToScreen(){
    switch (_index){
      case 0:
        return const HomeScreen();
        break;
      case 1:
        return const CreateTripScreen();
        break;
      case 2:
        return const ProfileScreen();
        break;
      default:
        return const Text("Hello");
    }
  }

  createNavigation(){
    return BottomNavigationBar(
      backgroundColor: myWhite,
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
