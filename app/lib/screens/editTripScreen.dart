import 'package:app/model/trip_model.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState(){
    tripID = widget.tripID;
    trip = widget.tripModel;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(tripID),
    );
  }
}
