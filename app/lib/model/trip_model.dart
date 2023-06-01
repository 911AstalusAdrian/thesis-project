import 'dart:convert';

class TripModel {
  final int people;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String transportation;

  const TripModel({
    required this.people,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.transportation
  });

  factory TripModel.fromJson(Map<String, dynamic> jsonData) =>
      TripModel(
        people: jsonData['people'],
        location: jsonData['location'],
        startDate: jsonData['startDate'],
        endDate: jsonData['endDate'],
        transportation: jsonData['transportation'],
      );

  Map<String, dynamic> toJson() => {
    'people': people,
    'location': location,
    'startDate': startDate,
    'endDate': endDate,
    'transportation': transportation,
  };
}