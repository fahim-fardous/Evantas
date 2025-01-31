import 'package:domain/model/event.dart';

abstract class EventRepository {
  Future<void> addEvent(Event event);
  Future<List<Event>> getEventList();
}