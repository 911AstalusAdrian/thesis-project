import 'package:flutter/material.dart';

import '../server/server.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final String uid = Server.getUID();



  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Text(uid),
      );
  }
}
