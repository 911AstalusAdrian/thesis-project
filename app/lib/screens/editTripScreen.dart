import 'package:app/model/trip_model.dart';
import 'package:app/widgets/fancyText.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/selectionCard.dart';

class EditTripScreen extends StatefulWidget {
  const EditTripScreen({Key? key,
  required this.tripID,
  required this.tripModel}) : super(key: key);

  final String tripID;
  final BasicTripModel tripModel;

  @override
  State<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {

  late final String tripID;
  late final BasicTripModel trip;

  String _tripName = "";
  final TextEditingController _tripNameCtrl = TextEditingController();

  String _invitedUser = "";
  final TextEditingController _inviteUserCtrl = TextEditingController();

  String _lodgingLocation = "";
  final TextEditingController _lodgingCtrl = TextEditingController();


  DateTime _startDate = DateTime.now();
  final TextEditingController _startDateController = TextEditingController();

  DateTime _endDate = DateTime.now();
  final TextEditingController _endDateController = TextEditingController();

  int _selectedPeopleIndex = -1;
  int _selectedTransportIndex = -1;

  String _selectedTransport = "";
  String _selectedCountry = "";



  @override
  void initState(){
    super.initState();
    tripID = widget.tripID;
    trip = widget.tripModel;
    _selectedTransport = trip.transportation;
    _startDateController.text = DateFormat("dd-MM-yyyy").format(trip.startDate);
    _endDateController.text = DateFormat("dd-MM-yyyy").format(trip.endDate);
    _selectedPeopleIndex = trip.people;
    switch (_selectedTransport){
      case 'car':
        _selectedTransportIndex = 0;
        break;
      case 'plane':
        _selectedTransportIndex = 1;
        break;
      case 'train':
        _selectedTransportIndex = 2;
        break;
      case 'other':
        _selectedTransportIndex = 3;
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FancyText(text: "Give a name to your Trip: "),
                      Expanded(
                        child: TextField(
                            controller: _tripNameCtrl,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(hintText: "Trip to ${trip.location}")
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Column(
                    children: [
                      const FancyText(text: "Where will you be staying?"),
                      TextField(
                        controller: _lodgingCtrl,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.location_on_outlined)
                        ),
                        onTap: () {
                          _openMap(context);
                        },
                      )
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
                      vertical: 10, horizontal: 25),
                  child: Column(
                    children: [
                      const FancyText(text: "Choose the dates:"),
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
                ElevatedButton(
                  onPressed: () async { },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text("Create Itinerary"),
                ),
                ElevatedButton(
                  onPressed: () async { },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text("Save"),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  _openMap(BuildContext context){}


}