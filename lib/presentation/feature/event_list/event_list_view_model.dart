import 'package:domain/model/event.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/route/add_reminder_argument.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/route/add_reminder_route.dart';
import 'package:hello_flutter/presentation/feature/event_details/route/event_details_argument.dart';
import 'package:hello_flutter/presentation/feature/event_details/route/event_details_route.dart';
import 'package:hello_flutter/presentation/feature/event_list/route/event_list_argument.dart';
import 'package:hello_flutter/presentation/util/value_notifier_list.dart';

import 'enum/event_type.dart';

class EventListViewModel extends BaseViewModel<EventListArgument> {
  final EventRepository eventRepository;

  final ValueNotifier<String> _message = ValueNotifier('EventList');

  ValueListenable<String> get message => _message;

  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  ValueListenable<int> get currentIndex => _currentIndex;

  final ValueNotifierList<EventType> _eventTypes = ValueNotifierList([
    EventType.dinner,
    EventType.development,
    EventType.birthday,
    EventType.special
  ]);

  ValueNotifierList<EventType> get eventTypes => _eventTypes;

  final ValueNotifierList<Event> _events = ValueNotifierList([]);

  ValueNotifierList<Event> get events => _events;

  EventListViewModel(this.eventRepository);

  @override
  void onViewReady({EventListArgument? argument}) {
    super.onViewReady();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final events = await loadData(eventRepository.getEventList());

    if (events.isNotEmpty) {
      _events.value = events;
    }
  }

  void setCurrentIndex(int index) {
    _currentIndex.value = index;
  }

  void onEventClicked({required int eventId}) {
    navigateToScreen(
        destination: EventDetailsRoute(arguments: EventDetailsArgument(eventId: eventId)));
  }

  void onAddEventButtonClicked() {
    navigateToScreen(
      destination: AddReminderRoute(
        arguments: AddReminderArgument(),
      ),
    );
  }
}
