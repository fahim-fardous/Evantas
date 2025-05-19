import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/issue_details/screen/issue_details_mobile_portrait.dart';

class IssueDetailsMobileLandscape extends IssueDetailsMobilePortrait {
  const IssueDetailsMobileLandscape({required super.viewModel, super.key, required super.issueId});

  @override
  State<StatefulWidget> createState() => IssueDetailsMobileLandscapeState();
}

class IssueDetailsMobileLandscapeState extends IssueDetailsMobilePortraitState {}
