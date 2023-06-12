import 'package:app/screens/mainNavigationScreen.dart';
import 'package:app/widgets/fancyText.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../model/trip_model.dart';
import '../firebaseHandler.dart';
import '../widgets/selectionCard.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({Key? key}) : super(key: key);

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {

  FirebaseHandler handler = FirebaseHandler();

  DateTime _startDate = DateTime.now();
  final TextEditingController _startDateController = TextEditingController();

  DateTime _endDate = DateTime.now();
  final TextEditingController _endDateController = TextEditingController();

  int _selectedPeopleIndex = -1;
  int _selectedTransportIndex = -1;

  String _selectedTransport = "";
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
                        FancyText(text: "How many people are going?"),
                        SizedBox(
                          height: 90.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              SelectionCard(
                                  isSelected: _selectedPeopleIndex == 1,
                                  onTap: () { setState(() { _selectedPeopleIndex = 1; });},
                                  value: '1',
                                  icon: const Icon(Icons.person_outline)),
                              SelectionCard(
                                  isSelected: _selectedPeopleIndex == 2,
                                  onTap: () { setState(() { _selectedPeopleIndex = 2; });},
                                  value: '2',
                                  icon: const Icon(Icons.people_outline)),
                              SelectionCard(
                                  isSelected: _selectedPeopleIndex == 3,
                                  onTap: () { setState(() { _selectedPeopleIndex = 3; });},
                                  value: '3',
                                  icon: const Icon(Icons.groups_outlined)),
                              SelectionCard(
                                  isSelected: _selectedPeopleIndex == 4,
                                  onTap: () { setState(() { _selectedPeopleIndex = 4; });},
                                  value: '4',
                                  icon: const Icon(Icons.group_add_outlined)),
                              SelectionCard(
                                  isSelected: _selectedPeopleIndex == 0,
                                  onTap: () { setState(() { _selectedPeopleIndex = 0; });},
                                  value: 'Don\'t know yet',
                                  icon: const Icon(Icons.question_mark_outlined))
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
                        FancyText(text: "Where do you plan on going?"),
                        DropdownSearch<String>(
                          showClearButton: true,
                          items: const  [
                            "United States",
                            "Italy",
                            "Japan",
                            "Spain",
                            "Morrocco",
                            "Romania"
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
                        FancyText(text: "Choose the dates:"),
                        TextFormField(
                          readOnly: true,
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
                        TextFormField(
                          readOnly: true,
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
                          validator: (value) {
                            print(value);
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
                        FancyText(text: "How do you plan on getting there?"),
                        SizedBox(
                          height: 90.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              SelectionCard(
                                  isSelected: _selectedTransportIndex == 0,
                                  onTap: () { setState(() { _selectedTransportIndex = 0;  _selectedTransport = "car";});},
                                  value: 'Car',
                                  icon: const Icon(Icons.car_rental_sharp)),
                              SelectionCard(
                                  isSelected: _selectedTransportIndex == 1,
                                  onTap: () { setState(() { _selectedTransportIndex = 1; _selectedTransport = "plane";});},
                                  value: 'Plane',
                                  icon: const Icon(Icons.airplanemode_on_outlined)),
                              SelectionCard(
                                  isSelected: _selectedTransportIndex == 2,
                                  onTap: () { setState(() { _selectedTransportIndex = 2; _selectedTransport = "train";});},
                                  value: 'Train',
                                  icon: const Icon(Icons.train_outlined)),
                              SelectionCard(
                                  isSelected: _selectedTransportIndex == 3,
                                  onTap: () { setState(() { _selectedTransportIndex = 3; _selectedTransport = "other";});},
                                  value: 'Other',
                                  icon: const Icon(Icons.emoji_transportation_outlined)),
                            ],
                          ),
                        ),
                  ])),
                  ElevatedButton(
                    onPressed: () async { _createTrip(); },
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

  Future _createTrip() async {

    final tripToSave = BasicTripModel(
      people: _selectedPeopleIndex,
      location: _selectedCountry,
      startDate: _startDate,
      endDate: _endDate,
      transportation: _selectedTransport
    );

    handler.addTrip(tripToSave);
    _showAlertDialog(context);
  }

  _showAlertDialog(BuildContext context){
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
