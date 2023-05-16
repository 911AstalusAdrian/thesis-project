import 'package:app/assets/Colors.dart';
import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: myGrey
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15.0))
          ),
          child: SizedBox(
            width: 70,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(child: Text(value, style: TextStyle(fontSize: value.length < 3 ? 30 : 15),),),
            )
          ),
        ),
      ),
    );
  }
}
