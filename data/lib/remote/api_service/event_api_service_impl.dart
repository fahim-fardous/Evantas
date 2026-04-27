import 'package:data/remote/api_client/api_client.dart';
import 'package:data/remote/api_service/event_api_service.dart';
import 'package:data/remote/request/event_upsert_request_dto.dart';
import 'package:data/remote/response/event_upsert_response_dto.dart';
import 'package:domain/model/event.dart';

class EventApiServiceImpl implements EventApiService {
  final ApiClient apiClient;

  EventApiServiceImpl({required this.apiClient});

  @override
  Future<EventUpsertResponseDto> createEvent({required Event event}) async {
    final payload = EventUpsertRequestDto.fromEvent(event);
    final response = await apiClient.post(
      '/api/v1/events/',
      data: payload.toJson(),
    );
    return EventUpsertResponseDto.fromJson(response);
  }

  @override
  Future<EventUpsertResponseDto> updateEvent({
    required int eventId,
    required Event event,
  }) async {
    final payload = EventUpsertRequestDto.fromEvent(event);
    final response = await apiClient.patch(
      '/api/v1/events/$eventId/',
      data: payload.toJson(),
    );
    return EventUpsertResponseDto.fromJson(response);
  }
}
