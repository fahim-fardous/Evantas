import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/add_reminder/screen/add_reminder_mobile_portrait.dart';

class AddReminderMobileLandscape extends AddReminderMobilePortrait {
  const AddReminderMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => AddReminderMobileLandscapeState();
}

class AddReminderMobileLandscapeState extends AddReminderMobilePortraitState {}
