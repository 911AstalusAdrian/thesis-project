import 'package:flutter/material.dart';

class FancyText extends StatelessWidget {
  FancyText({Key? key, required this.text, this.color}) : super(key: key);

  Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color ?? Colors.black,
          fontFamily: 'Kanit',
          fontSize: 18.0,
        ));
  }
}
