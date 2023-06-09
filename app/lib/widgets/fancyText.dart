import 'package:flutter/material.dart';

class FancyText extends StatelessWidget {
  const FancyText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontFamily: 'Kanit',
          fontSize: 18.0,
        ));
  }
}
