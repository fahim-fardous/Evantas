import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/feature/profile/screen/profile_mobile_portrait.dart';

class ProfileMobileLandscape extends ProfileMobilePortrait {
  const ProfileMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => ProfileMobileLandscapeState();
}

class ProfileMobileLandscapeState extends ProfileMobilePortraitState {}
