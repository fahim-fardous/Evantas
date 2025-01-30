import 'package:domain/model/event_type.dart';
import 'package:flutter/material.dart';

class EventResponse {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final EventType eventType;
  final TimeOfDay time;

  EventResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.eventType,
    required this.time,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      eventType: _getEventType(json['event_type']),
      time: TimeOfDay.fromDateTime(DateTime.parse(json['time'])),
    );
  }

  static EventType _getEventType(String eventType) {
    switch (eventType) {
      case 'development':
        return EventType.development;
      case 'dinner':
        return EventType.dinner;
      case 'birthday':
        return EventType.birthday;
      case 'special':
        return EventType.special;
      default:
        return EventType.unknown;
    }
  }
}
