import 'package:data/dummy/events.dart';
import 'package:data/mapper/event_mapper.dart';
import 'package:data/service/supabase_service.dart';
import 'package:domain/model/event.dart';
import 'package:domain/repository/event_repository.dart';

class EventRepositoryImpl extends EventRepository {
  final SupabaseService supabaseService;

  EventRepositoryImpl(this.supabaseService);

  @override
  Future<void> addEvent(Event event) async {
    await supabaseService.addEvent(event);
  }

  @override
  Future<List<Event>> getEventList() async {
    final events = await supabaseService.getEvents();
    return events
        .map((event) => EventMapper.mapResponseToDomain(event))
        .toList();
  }

  @override
  Future<Event?> getEventById(int id) async {
    final event = await supabaseService.getEventById(id);
    if(event == null) {
      return null;
    }
    return EventMapper.mapResponseToDomain(event);
  }
}
