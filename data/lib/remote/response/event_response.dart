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
      time: _parseTime(json['time']),
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

  static TimeOfDay _parseTime(String time) {
    if (time.isEmpty) return const TimeOfDay(hour: 0, minute: 0); // Default value
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
