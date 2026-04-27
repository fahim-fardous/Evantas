import 'package:domain/model/event.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/event_details/route/event_details_argument.dart';
import 'package:evntas/presentation/feature/add_reminder/route/add_reminder_argument.dart';
import 'package:evntas/presentation/feature/add_reminder/route/add_reminder_route.dart';

class EventDetailsViewModel extends BaseViewModel<EventDetailsArgument> {
  final EventRepository eventRepository;
  final AppRepository appRepository;

  final ValueNotifier<Event?> _event = ValueNotifier(null);
  final ValueNotifier<bool> _canEdit = ValueNotifier(false);
  final ValueNotifier<List<String>> _attendeeNames = ValueNotifier([]);
  final ValueNotifier<bool> _isJoined = ValueNotifier(false);

  ValueNotifier<Event?> get event => _event;
  ValueNotifier<bool> get canEdit => _canEdit;
  ValueNotifier<List<String>> get attendeeNames => _attendeeNames;
  ValueNotifier<bool> get isJoined => _isJoined;

  EventDetailsViewModel(
    this.eventRepository,
    this.appRepository,
  );

  @override
  void onViewReady({EventDetailsArgument? argument}) {
    super.onViewReady();
    _fetchEvents(id: argument!.eventId);
    _fetchAttendeeNames(id: argument.eventId);
    _resolveJoinedStatus(id: argument.eventId);
  }

  Future<void> _resolveCanEdit(String? createdBy) async {
    if (createdBy == null || createdBy.trim().isEmpty) {
      _canEdit.value = false;
      return;
    }
    final userId = await appRepository.getUserId();
    _canEdit.value = userId != null && userId == createdBy;
  }

  Future<void> _fetchEvents({required int id}) async {
    final event = await loadData(eventRepository.getEventById(id));

    if (event != null) {
      _event.value = event;
      _resolveCanEdit(event.createdBy);
    }
  }

  Future<void> onJoinButtonClicked(int id) async {
    final userId = await appRepository.getUserId();
    if (userId == null) return;
    final isJoined = await loadData(eventRepository.isJoined(id, userId));

    if (isJoined) {
      _isJoined.value = true;
      showToast(
        uiText: FixedUiText(
          text: "You are already joined",
        ),
      );
      return;
    }

    await loadData(eventRepository.joinEvent(id, userId));
    _isJoined.value = true;
    _fetchAttendeeNames(id: id);
  }

  Future<void> _fetchAttendeeNames({required int id}) async {
    final names = await loadData(eventRepository.getEventAttendeeNames(id));
    _attendeeNames.value = names;
  }

  Future<void> _resolveJoinedStatus({required int id}) async {
    final userId = await appRepository.getUserId();
    if (userId == null) {
      _isJoined.value = false;
      return;
    }
    final joined = await loadData(eventRepository.isJoined(id, userId));
    _isJoined.value = joined;
  }

  void onBackButtonPressed() {
    navigateBack();
  }

  void onEventEditRequested({required bool editable}) {
    final selectedEvent = _event.value;
    if (selectedEvent == null) return;
    navigateToScreen(
      destination: AddReminderRoute(
        arguments: AddReminderArgument(
          existingEvent: selectedEvent,
          isEditable: editable,
        ),
      ),
    );
  }
}
