import 'package:data/remote/response/event_response.dart';
import 'package:domain/model/event.dart';

class EventMapper {
  static Event mapResponseToDomain(EventResponse event) {
    return Event(
      id: event.id,
      title: event.title,
      description: event.description,
      date: event.date,
      location: event.location,
      eventType: event.eventType,
      time: event.time
    );
  }
}