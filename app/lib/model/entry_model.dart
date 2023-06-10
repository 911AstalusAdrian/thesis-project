import 'package:flutter/material.dart';


class ItineraryEntry{
  final String title;
  final String description;
  final String date;
  final String startTime;
  final String endTime;

  const ItineraryEntry({
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime
  });

  factory ItineraryEntry.fromJson(Map<String, dynamic> jsonData) =>
      ItineraryEntry(
          title: jsonData['title'],
          description: jsonData['description'],
          date: jsonData['date'],
          startTime: jsonData['startTime'],
          endTime: jsonData['endTime']);

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'date': date,
    'startTime': startTime,
    'endTime': endTime,
  };
}