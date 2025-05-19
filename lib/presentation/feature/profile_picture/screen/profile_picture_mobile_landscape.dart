import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/profile_picture/screen/profile_picture_mobile_portrait.dart';

class ProfilePictureMobileLandscape extends ProfilePictureMobilePortrait {
  const ProfilePictureMobileLandscape({required super.viewModel, super.key, required super.profilePhotoUrl});

  @override
  State<StatefulWidget> createState() => ProfilePictureMobileLandscapeState();
}

class ProfilePictureMobileLandscapeState extends ProfilePictureMobilePortraitState {}
