import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/memory/screen/memory_mobile_portrait.dart';

class MemoryMobileLandscape extends MemoryMobilePortrait {
  const MemoryMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => MemoryMobileLandscapeState();
}

class MemoryMobileLandscapeState extends MemoryMobilePortraitState {}
