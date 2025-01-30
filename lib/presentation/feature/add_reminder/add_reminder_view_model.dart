import 'package:domain/model/event_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/route/add_reminder_argument.dart';
import 'package:hello_flutter/presentation/util/time_formatter.dart';
import 'package:intl/intl.dart';

class AddReminderViewModel extends BaseViewModel<AddReminderArgument> {
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

  AddReminderViewModel();

  @override
  void onViewReady({AddReminderArgument? argument}) {
    super.onViewReady();
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
    _message.value = 'Saving Reminder';
    await Future.delayed(const Duration(seconds: 2));
    _message.value = 'Reminder Saved';
  }

  void onBackButtonPressed() {
    navigateBack();
  }
}
