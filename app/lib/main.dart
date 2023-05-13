import 'package:app/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'assets/Colors.dart';

void main() {
  runApp(const Main());
}
class Main extends StatelessWidget{

  const Main ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: myWhite
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}