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
              'fahim_attendee.jpg',
        ),
        Person(
          id: 1,
          name: 'Md. Faisal Ahammed',
          profilePhotoUrl:
              'faisal_attendee.jpg',
        ),
        Person(
          id: 2,
          name: 'Rayhah Mahmud',
          profilePhotoUrl:
              'profile_avatar.png',
        ),
        Person(
          id: 3,
          name: 'Rakib Anam Rohid',
          profilePhotoUrl:
              'profile_avatar.png',
        ),
      ],
    ),
  ];
}
