import 'package:domain/model/event_type.dart';

class EventResponse {
  final int id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final EventType eventType;

  EventResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.eventType,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      location: json['location'],
      eventType: _getEventType(json['event_type']),
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
