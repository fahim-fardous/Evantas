import 'package:domain/model/event.dart';

class EventUpsertRequestDto {
  final String? createdBy;
  final String title;
  final String? description;
  final String date;
  final String time;
  final String location;
  final String eventType;

  EventUpsertRequestDto({
    required this.createdBy,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.eventType,
  });

  factory EventUpsertRequestDto.fromEvent(Event event) {
    final hour = event.time.hour.toString().padLeft(2, '0');
    final minute = event.time.minute.toString().padLeft(2, '0');
    return EventUpsertRequestDto(
      createdBy: event.createdBy,
      title: event.title,
      description: event.description,
      date: event.date.toIso8601String().split('T')[0],
      time: '$hour:$minute:00',
      location: event.location,
      eventType: event.eventType.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'created_by': createdBy,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'event_type': eventType,
    };
  }
}
