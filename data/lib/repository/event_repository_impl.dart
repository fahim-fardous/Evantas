import 'package:data/dummy/events.dart';
import 'package:domain/model/event.dart';
import 'package:domain/repository/event_repository.dart';

class EventRepositoryImpl extends EventRepository {
  @override
  Future<List<Event>> getEventList() async {
    return Events.events;
  }
}
