import 'package:domain/model/event.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/event_details/route/event_details_argument.dart';
import 'package:hello_flutter/presentation/feature/event_list/route/event_list_argument.dart';
import 'package:hello_flutter/presentation/util/value_notifier_list.dart';

class EventDetailsViewModel extends BaseViewModel<EventDetailsArgument> {
  final EventRepository eventRepository;

  final ValueNotifierList<Event> _events = ValueNotifierList([]);

  ValueNotifierList<Event> get events => _events;

  EventDetailsViewModel(this.eventRepository);

  @override
  void onViewReady({EventDetailsArgument? argument}) {
    super.onViewReady();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    List<Event> events = await loadData(eventRepository.getEventList());

    if (events.isNotEmpty) {
      _events.value = events;
    }
  }

  void onBackButtonPressed(){
    navigateBack();
  }
}
