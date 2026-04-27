class EventUpsertResponseDto {
  final int id;
  final String title;
  final String? description;
  final String date;
  final String time;
  final String location;
  final String eventType;

  EventUpsertResponseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.eventType,
  });

  factory EventUpsertResponseDto.fromJson(Map<String, dynamic> json) {
    return EventUpsertResponseDto(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'],
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      location: json['location'] ?? '',
      eventType: json['event_type'] ?? '',
    );
  }
}
