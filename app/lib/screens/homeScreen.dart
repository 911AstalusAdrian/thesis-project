import 'package:app/screens/createTripScreen.dart';
import 'package:app/screens/profileScreen.dart';
import 'package:flutter/material.dart';

import '../widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("Home"),
      );
  }
}
