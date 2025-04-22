import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/edit_profile/screen/edit_profile_mobile_portrait.dart';

class EditProfileMobileLandscape extends EditProfileMobilePortrait {
  const EditProfileMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => EditProfileMobileLandscapeState();
}

class EditProfileMobileLandscapeState extends EditProfileMobilePortraitState {}
