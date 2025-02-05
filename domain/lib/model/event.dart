import 'package:domain/model/event_type.dart';
import 'package:domain/model/event_type.dart';
import 'package:flutter/material.dart';

class Event {
  final int id;
  final String title;
  final String? description;
  final DateTime date;
  final TimeOfDay time;
  final String location;
  final EventType eventType;

  Event({
    this.id = 0,
    required this.title,
    this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.eventType,
  });
}
