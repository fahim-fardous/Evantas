import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/add_event/screen/add_event_mobile_portrait.dart';

class AddEventMobileLandscape extends AddEventMobilePortrait {
  const AddEventMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => AddEventMobileLandscapeState();
}

class AddEventMobileLandscapeState extends AddEventMobilePortraitState {}
