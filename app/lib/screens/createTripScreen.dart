import 'package:app/widgets/fancyText.dart';
import 'package:flutter/material.dart';

import '../assets/Colors.dart';
import '../widgets/selectionCard.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({Key? key}) : super(key: key);

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: const Color(0xFFDADADA)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const FancyText(text: "How many people are going?"),
                      SizedBox(
                        height: 150.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: const [
                            SelectionCard(value: '1'),
                            SelectionCard(value: '2'),
                            SelectionCard(value: '3'),
                            SelectionCard(value: '4+'),
                          ],
                        ),
                      ),
                      const FancyText(text: "Where do you plan on going?"),
                      const FancyText(text: "Choose the dates:"),
                      const FancyText(text: "How do you plan on getting there?"),
                      ElevatedButton(onPressed: () {}, child: const Text("Create my Trip!"))
                    ],
                  ),
                ),
              ),
            ),
          ),
    ));
  }
}
