import 'package:domain/model/event.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/event_details/route/event_details_argument.dart';

class EventDetailsViewModel extends BaseViewModel<EventDetailsArgument> {
  final EventRepository eventRepository;
  final AppRepository appRepository;

  final ValueNotifier<Event?> _event = ValueNotifier(null);

  ValueNotifier<Event?> get event => _event;

  EventDetailsViewModel(
    this.eventRepository,
    this.appRepository,
  );

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

  Future<void> onJoinButtonClicked(int id) async {
    final userId = await appRepository.getUserId();
    if (userId == null) return;
    final isJoined = await loadData(eventRepository.isJoined(id, userId));

    if (isJoined) {
      showToast(
        uiText: FixedUiText(
          text: "You are already joined",
        ),
      );
      return;
    }

    await loadData(eventRepository.joinEvent(id, userId));

    navigateBack();
  }

  void onBackButtonPressed() {
    navigateBack();
  }
}
