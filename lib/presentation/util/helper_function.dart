import 'package:domain/model/event.dart';

class HelperFunction {
  static Map<DateTime, List<Event>> groupEventsByDate(List<Event> events) {
    Map<DateTime, List<Event>> groupedEvents = {};

    for (var event in events) {
      final date = DateTime(event.date.year, event.date.month, event.date.day);
      groupedEvents.putIfAbsent(date, () => []).add(event);
    }

    final sortedKeys = groupedEvents.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    Map<DateTime, List<Event>> sortedGroupedEvents = {
      for (var key in sortedKeys) key: groupedEvents[key]!
    };

    return sortedGroupedEvents;
  }
}