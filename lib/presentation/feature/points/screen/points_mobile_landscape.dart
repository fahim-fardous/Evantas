import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/points/screen/points_mobile_portrait.dart';

class PointsMobileLandscape extends PointsMobilePortrait {
  const PointsMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => PointsMobileLandscapeState();
}

class PointsMobileLandscapeState extends PointsMobilePortraitState {}
