import 'package:domain/model/event.dart';
import 'package:domain/model/event_type.dart';
import 'package:domain/model/event_type.dart';
import 'package:flutter/material.dart';

class Events {
  static List<Event> events = [
    Event(
      id: 0,
      title: 'Event 1',
      description: 'Description 1',
      date: DateTime(2022, 1, 1),
      time: const TimeOfDay(hour: 12, minute: 0),
      location: 'Banani, Dhaka',
      eventType: EventType.birthday,
    ),
  ];
}