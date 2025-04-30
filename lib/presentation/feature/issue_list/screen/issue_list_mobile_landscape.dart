import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/issue_list/screen/issue_list_mobile_portrait.dart';

class IssueListMobileLandscape extends IssueListMobilePortrait {
  const IssueListMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => IssueListMobileLandscapeState();
}

class IssueListMobileLandscapeState extends IssueListMobilePortraitState {}
