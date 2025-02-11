import 'dart:io';

import 'package:data/remote/response/event_response.dart';
import 'package:data/remote/response/memory_response.dart';
import 'package:domain/model/event.dart';
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
    final response = await supabaseClient.from('events').select()
        .eq('id', id)
        .single();
    return EventResponse.fromJson(response);
  }

  Future<void> saveImage(String imagePath) async {
    await supabaseClient.from('memories').insert({
      'image_path': imagePath,
      'uploaded_by': '10BTd%6shsFDG'
    });
  }

  Future<List<MemoryResponse>> getImages() async {
    final response = await supabaseClient.from('memories').select();
    return response.map((memory){
      return MemoryResponse.fromJson(memory);
    }).toList();
  }
}
