import 'package:data/dummy/events.dart';
import 'package:data/service/supabase_service.dart';
import 'package:domain/model/event.dart';
import 'package:domain/repository/event_repository.dart';

class EventRepositoryImpl extends EventRepository {
  final SupabaseService supabaseService;

  EventRepositoryImpl(this.supabaseService);
  @override
  Future<List<Event>> getEventList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Events.events;
  }

  @override
  Future<void> addEvent(Event event) async{
    await supabaseService.addEvent(event);
  }
}
