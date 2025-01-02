import 'package:domain/model/event.dart';
import 'package:domain/model/person.dart';

class Events {
  static List<Event> events = [
    Event(
      id: 0,
      title: 'Event 1',
      description: 'Description 1',
      startDate: DateTime(2022, 1, 1),
      endDate: DateTime(2022, 1, 2),
      location: 'Banani, Dhaka',
      attendees: [
        Person(
          id: 0,
          name: 'Fahim Mohammod Fardous',
          profilePhotoUrl:
              'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=76&q=80',
        ),
      ],
    ),
  ];
}
