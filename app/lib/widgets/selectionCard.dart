import 'package:app/assets/Colors.dart';
import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: myGrey
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15.0))
        ),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Center(child: Text(value, style: TextStyle(fontSize: 30),),),
        ),
      ),
    );
  }
}
