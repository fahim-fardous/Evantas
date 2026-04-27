import 'package:data/remote/response/event_upsert_response_dto.dart';
import 'package:domain/model/event.dart';

abstract class EventApiService {
  Future<EventUpsertResponseDto> createEvent({required Event event});

  Future<EventUpsertResponseDto> updateEvent({
    required int eventId,
    required Event event,
  });
}
