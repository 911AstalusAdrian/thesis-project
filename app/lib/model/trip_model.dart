import 'dart:convert';

class BasicTripModel {
  final int people;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String transportation;
  final bool hasItinerary;

  const BasicTripModel(
      {required this.people,
      required this.location,
      required this.startDate,
      required this.endDate,
      required this.transportation,
        this.hasItinerary = false});

  factory BasicTripModel.fromJson(Map<String, dynamic> jsonData) => BasicTripModel(
        people: jsonData['people'],
        location: jsonData['location'],
        startDate: jsonData['startDate'],
        endDate: jsonData['endDate'],
        transportation: jsonData['transportation'],
        hasItinerary: jsonData['hasItinerary']
      );

  Map<String, dynamic> toJson() => {
        'people': people,
        'location': location,
        'startDate': startDate,
        'endDate': endDate,
        'transportation': transportation,
        'hasItinerary': hasItinerary
      };
}

class TripWithOwner {
  final String owner;
  final BasicTripModel tripDetails;

  const TripWithOwner({required this.owner, required this.tripDetails});

  factory TripWithOwner.fromJson(Map<String, dynamic> jsonData) =>
      TripWithOwner(
          owner: jsonData['owner'],
          tripDetails: BasicTripModel(
              people: jsonData['people'],
              location: jsonData['location'],
              startDate: jsonData['startDate'],
              endDate: jsonData['endDate'],
              transportation: jsonData['transportation'],
              hasItinerary: jsonData['hasItinerary']));

  Map<String, dynamic> toJson() => {
        'owner': owner,
        'people': tripDetails.people,
        'location': tripDetails.location,
        'startDate': tripDetails.startDate,
        'endDate': tripDetails.endDate,
        'transportation': tripDetails.transportation,
        'hasItinerary': tripDetails.hasItinerary
      };
}
