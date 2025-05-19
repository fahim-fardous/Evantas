import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/memory_details/screen/memory_details_mobile_portrait.dart';

class MemoryDetailsMobileLandscape extends MemoryDetailsMobilePortrait {
  const MemoryDetailsMobileLandscape({required super.initialIndex, required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => MemoryDetailsMobileLandscapeState();
}

class MemoryDetailsMobileLandscapeState extends MemoryDetailsMobilePortraitState {}
