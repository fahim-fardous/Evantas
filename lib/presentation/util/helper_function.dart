import 'package:domain/model/event.dart';
import 'package:intl/intl.dart';

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

  static String timeAgo(DateTime createdAt) {
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours <= 12) {
      return '${diff.inHours} hr ago';
    } else {
      final days = diff.inDays;
      return days == 1 ? '1 day ago' : '$days days ago';
    }
  }
}
