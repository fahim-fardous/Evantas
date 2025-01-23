import 'package:data/remote/response/event_response.dart';
import 'package:domain/model/event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  Future<void> addEvent(Event event) async {
    await supabaseClient.from('events').insert({
      'title': event.title,
      'description': event.description,
      'start_date': event.startDate,
      'end_date': event.endDate,
      'location': event.location,
    });
  }

  Future<EventResponse> getEvents() async {
    dynamic response = await supabaseClient.from('events').select();

    return EventResponse.fromJson(response);
  }
}
