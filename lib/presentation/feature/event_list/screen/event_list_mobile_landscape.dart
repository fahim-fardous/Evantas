import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/event_list/screen/event_list_mobile_portrait.dart';

class EventListMobileLandscape extends EventListMobilePortrait {
  const EventListMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => EventListMobileLandscapeState();
}

class EventListMobileLandscapeState extends EventListMobilePortraitState {}
