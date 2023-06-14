import 'package:flutter/material.dart';

class FancyText extends StatelessWidget {
  FancyText({Key? key, required this.text, this.color, this.fontSize}) : super(key: key);

  Color? color;
  final String text;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color ?? Colors.black,
          fontFamily: 'Kanit',
          fontSize: fontSize ?? 18.0,
        ));
  }
}
