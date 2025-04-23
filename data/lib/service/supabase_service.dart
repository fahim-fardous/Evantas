import 'package:data/mapper/google_user_mapper.dart';
import 'package:data/remote/response/event_response.dart';
import 'package:data/remote/response/user_response.dart';
import 'package:domain/model/event.dart';
import 'package:domain/model/google_user_data.dart';
import 'package:domain/util/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabaseClient;

  SupabaseService({required this.supabaseClient});

  Future<void> addEvent(Event event) async {
    await supabaseClient.from('events').insert({
      'title': event.title,
      'description': event.description,
      'date': event.date.toIso8601String().split('T')[0],
      'location': event.location,
      'event_type': event.eventType.name,
      'time': "${event.time.hour}:${event.time.minute}",
    });
  }

  Future<List<EventResponse>> getEvents() async {
    final response = await supabaseClient.from('events').select();
    return response.map((event) {
      return EventResponse.fromJson(event);
    }).toList();
  }

  Future<EventResponse?> getEventById(int id) async {
    final response =
        await supabaseClient.from('events').select().eq('id', id).single();
    return EventResponse.fromJson(response);
  }

  Future<void> addUser(GoogleUserData user) async {
    await supabaseClient.from('users').insert({
      'name': user.name,
      'email': user.email,
      'photo_url': user.photoUrl,
      'fcm_token': user.id,
      'role': 'admin',
      'user_id': user.id
    });
  }

  Future<UserDataResponse?> getUserById(String userId) async {
    try {
      final isUserExists = await supabaseClient
          .from('users')
          .select()
          .eq('user_id', userId)
          .limit(1)
          .maybeSingle();

      if (isUserExists == null) {
        return null;
      }

      final response = await supabaseClient
          .from('users')
          .select()
          .eq('user_id', userId)
          .single();
      return UserDataResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}
