import 'package:domain/model/event.dart';

abstract class EventRepository {
  Future<void> addEvent(Event event);
  Future<List<Event>> getEventList();
  Future<Event?> getEventById(int id);
  Future<void> joinEvent(int id, String userId);
  Future<bool> isJoined(int id, String userId);
}