import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/event_details/screen/event_details_mobile_portrait.dart';

class EventDetailsMobileLandscape extends EventDetailsMobilePortrait {
  const EventDetailsMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => EventDetailsMobileLandscapeState();
}

class EventDetailsMobileLandscapeState extends EventDetailsMobilePortraitState {}
