import 'dart:convert';

import 'package:get/get.dart';

class BasicTripModel {
  final int people;
  final String title;
  final String location;
  final String lodging;
  final DateTime startDate;
  final DateTime endDate;
  final String transportation;
  final bool hasItinerary;

  const BasicTripModel(
      {required this.people,
        this.title = "Default Trip",
      required this.location,
        this.lodging = "",
      required this.startDate,
      required this.endDate,
      required this.transportation,
        this.hasItinerary = false});

  factory BasicTripModel.fromJson(Map<String, dynamic> jsonData) => BasicTripModel(
        people: jsonData['people'],
        title: jsonData['title'],
        location: jsonData['location'],
        lodging: jsonData['lodging'],
        startDate: jsonData['startDate'].toDate(),
        endDate: jsonData['endDate'].toDate(),
        transportation: jsonData['transportation'],
        hasItinerary: jsonData['hasItinerary']
      );

  Map<String, dynamic> toJson() => {
        'people': people,
        'title': title == "Default Trip" ? "Trip to $location" : title,
        'location': location,
        'lodging': lodging,
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
          tripDetails: BasicTripModel.fromJson(jsonData));

  Map<String, dynamic> toJson() {
    Map<String, dynamic> finalMap = <String, dynamic>{};
    finalMap.assign('owner', owner);
    finalMap.addAll(tripDetails.toJson());
    return finalMap;
  }
}
