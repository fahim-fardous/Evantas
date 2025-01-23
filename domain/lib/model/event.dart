import 'package:domain/model/event_type.dart';
import 'package:domain/model/event_type.dart';

class Event {
  final int id;
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final EventType eventType;

  Event({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.eventType,
  });
}
