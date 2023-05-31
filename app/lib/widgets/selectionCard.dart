import 'package:app/assets/Colors.dart';
import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({Key? key,
    required this.isSelected,
    required this.onTap,
    required this.value,
    required this.icon})
      : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final String value;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            child: Card(
              color: isSelected ? myOrange : myGrey,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Padding(
                  padding:
                  const EdgeInsets.only(left: 15.0),
                  child: Row(children: [
                    icon,
                    SizedBox(
                        width: 85,
                        height: 55,
                        child: Center(
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: value.length < 3 ? 25 : 15,
                                color: Colors.white),
                          ),
                        )
                    ),
                  ])),
            )),
      ),
    );
  }
}
