import 'package:domain/model/event.dart';

abstract class EventRepository {
  Future<List<Event>> getEventList();
}