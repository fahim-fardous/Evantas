import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final time = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  final format = DateFormat.jm(); // This is for "hh:mm a" format
  return format.format(time);
}
