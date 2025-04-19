import 'package:domain/model/event.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/event_details/route/event_details_argument.dart';

class EventDetailsViewModel extends BaseViewModel<EventDetailsArgument> {
  final EventRepository eventRepository;

  final ValueNotifier<Event?> _event = ValueNotifier(null);

  ValueNotifier<Event?> get event => _event;

  EventDetailsViewModel(this.eventRepository);

  @override
  void onViewReady({EventDetailsArgument? argument}) {
    super.onViewReady();
    _fetchEvents(id: argument!.eventId);
  }

  Future<void> _fetchEvents({required int id}) async {
    final event = await loadData(eventRepository.getEventById(id));

    if (event != null) {
      _event.value = event;
    }
  }

  void onBackButtonPressed(){
    navigateBack();
  }
}
