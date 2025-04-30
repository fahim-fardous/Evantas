import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/add_issue/screen/add_issue_mobile_portrait.dart';

class AddIssueMobileLandscape extends AddIssueMobilePortrait {
  const AddIssueMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => AddIssueMobileLandscapeState();
}

class AddIssueMobileLandscapeState extends AddIssueMobilePortraitState {}
