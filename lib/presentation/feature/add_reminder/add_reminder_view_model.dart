import 'package:domain/model/event.dart';
import 'package:domain/model/event_type.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:domain/util/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/add_reminder/route/add_reminder_argument.dart';
import 'package:evntas/presentation/localization/text_id.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:evntas/presentation/util/time_formatter.dart';
import 'package:intl/intl.dart';

class AddReminderViewModel extends BaseViewModel<AddReminderArgument> {
  final EventRepository eventRepository;
  final ValueNotifier<String> _message = ValueNotifier('AddReminder');

  ValueListenable<String> get message => _message;

  final ValueNotifier<DateTime> _date = ValueNotifier(DateTime.now());

  ValueListenable<DateTime> get date => _date;

  final ValueNotifier<String?> _title = ValueNotifier(null);

  ValueListenable<String?> get title => _title;

  final ValueNotifier<String?> _description = ValueNotifier(null);

  ValueListenable<String?> get description => _description;

  final ValueNotifier<String?> _location = ValueNotifier(null);

  ValueListenable<String?> get location => _location;

  final ValueNotifier<EventType> _eventType = ValueNotifier(EventType.dinner);

  ValueListenable<EventType> get eventType => _eventType;

  final ValueNotifier<TimeOfDay> _time = ValueNotifier(TimeOfDay.now());

  ValueListenable<TimeOfDay> get time => _time;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController eventTypeController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  int count = 0;
  Event? _existingEvent;
  final ValueNotifier<bool> _isEditable = ValueNotifier(true);
  ValueListenable<bool> get isEditable => _isEditable;
  final ValueNotifier<bool> _isEditMode = ValueNotifier(false);
  ValueListenable<bool> get isEditMode => _isEditMode;

  AddReminderViewModel({required this.eventRepository});

  @override
  void onViewReady({AddReminderArgument? argument}) {
    super.onViewReady();
    _isEditable.value = argument?.isEditable ?? true;
    _existingEvent = argument?.existingEvent;
    _isEditMode.value = _existingEvent != null;
    final event = _existingEvent;
    if (event != null) {
      _date.value = event.date;
      _time.value = event.time;
      _eventType.value = event.eventType;
      titleController.text = event.title;
      descriptionController.text = event.description ?? '';
      locationController.text = event.location;
      dateController.text = DateFormat('MMM d, yyyy').format(event.date);
      timeController.text = formatTimeOfDay(event.time);
    }
  }

  void onDateSelected(DateTime date) {
    _date.value = date;
    dateController.text = DateFormat('MMM d, yyyy').format(date);
  }

  void onTimeSelected(TimeOfDay time) {
    _time.value = time;
    timeController.text = formatTimeOfDay(time);
  }

  void onEventTypeSelected(EventType eventType) {
    _eventType.value = eventType;
  }

  Future<void> onSaveButtonClicked() async {
    if (!_isEditable.value) {
      return;
    }
    if (titleController.text.trim().isEmpty ||
        dateController.text.trim().isEmpty ||
        timeController.text.trim().isEmpty ||
        locationController.text.trim().isEmpty) {
      showToast(
        uiText: DynamicUiText(
          textId: PleaseFillUpAllTheRequiredFieldsTextId(),
          fallbackText: "Please fill up all fields",
        ),
      );
      return;
    }

    final event = Event(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      date: _date.value,
      location: locationController.text.trim(),
      eventType: _eventType.value,
      time: _time.value,
    );
    Logger.debug(
      "Event: ${event.title} ${event.date} ${event.time} ${event.eventType} ${event.location}",
    );
    if (_existingEvent == null) {
      await loadData(eventRepository.addEvent(event));
    } else {
      await loadData(
        eventRepository.updateEvent(eventId: _existingEvent!.id, event: event),
      );
    }
    navigateBack();
  }

  void onBackButtonPressed() {
    navigateBack();
  }

  @override
  void onDispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    eventTypeController.dispose();
    timeController.dispose();
    dateController.dispose();
    _isEditMode.dispose();
    super.onDispose();
  }
}
