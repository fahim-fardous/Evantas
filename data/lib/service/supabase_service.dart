import 'package:data/remote/response/event_response.dart';
import 'package:domain/model/event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabaseClient;

  SupabaseService({required this.supabaseClient});

  Future<void> addEvent(Event event) async {
    await supabaseClient.from('events').insert({
      'id': event.id,
      'title': event.title,
      'description': event.description,
      'date': event.date.toIso8601String(),
      'location': event.location,
      'event_type': event.eventType.name,
      'time': "${event.time.hour}:${event.time.minute}",
    });
  }

  Future<EventResponse> getEvents() async {
    dynamic response = await supabaseClient.from('events').select();

    return EventResponse.fromJson(response);
  }
}
