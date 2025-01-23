import 'package:domain/model/event.dart';
import 'package:domain/model/event_type.dart';
import 'package:domain/model/event_type.dart';

class Events {
  static List<Event> events = [
    Event(
      id: 0,
      title: 'Event 1',
      description: 'Description 1',
      startDate: DateTime(2022, 1, 1),
      endDate: DateTime(2022, 1, 2),
      location: 'Banani, Dhaka',
      eventType: EventType.birthday,
    ),
  ];
}