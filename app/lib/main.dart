import 'dart:async';

import 'package:app/notificationsHandler.dart';
import 'package:app/screens/loginScreen.dart';
import 'package:app/screens/mainNavigationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'assets/Colors.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Main());

}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    MessagesHandler.setupMessaging();

    return MaterialApp(

      initialRoute:
        FirebaseAuth.instance.currentUser == null ? "/login" : "/home",

      routes: {
        "/login": (context) => const LoginScreen(),
        "/home": (context) => MainNavigationScreen(index: 0)
      },



      theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: myWhite
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}