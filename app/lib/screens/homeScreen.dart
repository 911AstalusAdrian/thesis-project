import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;



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
