import 'package:app/screens/mainNavigationScreen.dart';
import 'package:app/screens/profileScreen.dart';
import 'package:app/widgets/fancyText.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../assets/Colors.dart';
import '../widgets/selectionCard.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({Key? key}) : super(key: key);

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  DateTime _startDate = DateTime.now();
  TextEditingController _startDateController = TextEditingController();

  DateTime _endDate = DateTime.now();
  TextEditingController _endDateController = TextEditingController();

  String _selectedCountry = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Color(0xFFDADADA)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0),
                    child: Column(
                      children: [
                        const FancyText(text: "How many people are going?"),
                        SizedBox(
                          height: 90.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: const [
                              SelectionCard(value: '1', icon: Icon(Icons.person_outline)),
                              SelectionCard(value: '2', icon: Icon(Icons.people_outline)),
                              SelectionCard(value: '3', icon: Icon(Icons.groups_outlined)),
                              SelectionCard(value: '4+', icon: Icon(Icons.group_add_outlined)),
                              SelectionCard(value: 'Don\'t know yet', icon: Icon(Icons.question_mark_outlined))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: Column(
                      children: [
                        const FancyText(text: "Where do you plan on going?"),
                        DropdownSearch<String>(
                          showClearButton: true,
                          items: [
                            "United States",
                            "Italy",
                            "Japan",
                            "Spain",
                            "Morrocco"
                          ], // TODO get countries from some sort of repo
                          dropdownSearchDecoration: const InputDecoration(
                            labelText: "Choose a country",
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedCountry = value ?? "";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Column(
                      children: [
                        const FancyText(text: "Choose the dates:"),
                        TextField(
                          controller: _startDateController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: "Start Date"),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2040));

                            setState(() {
                              _startDate = pickedDate ?? DateTime.now();
                              _startDateController.text =
                                  "${_startDate.day}/${_startDate.month}/${_startDate.year}";
                            });
                          },
                        ),
                        TextField(
                          controller: _endDateController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: "End Date"),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2040));

                            setState(() {
                              _endDate = pickedDate ?? DateTime.now();
                              _endDateController.text =
                                  "${_endDate.day}/${_endDate.month}/${_endDate.year}";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Column(
                      children:[
                        const FancyText(text: "How do you plan on getting there?"),
                        SizedBox(
                          height: 90.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: const [
                              SelectionCard(value: 'Car', icon: Icon(Icons.car_rental_outlined)),
                              SelectionCard(value: 'Plane', icon: Icon(Icons.airplanemode_on_outlined)),
                              SelectionCard(value: 'Train', icon: Icon(Icons.train_outlined)),
                              SelectionCard(value: 'Other', icon: Icon(Icons.emoji_transportation_outlined)),
                            ],
                          ),
                        ),
                  ])),
                  ElevatedButton(
                    onPressed: () async {
                      showAlertDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text("Create my Trip!"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  showAlertDialog(BuildContext context){
    AlertDialog alert = AlertDialog(
      title: const Text("Trip Created!"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainNavigationScreen(index: 2)));},
            child: const Text("OK")),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
