import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/user_onboarding/screen/user_onboarding_mobile_portrait.dart';

class UserOnboardingMobileLandscape extends UserOnboardingMobilePortrait {
  const UserOnboardingMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => UserOnboardingMobileLandscapeState();
}

class UserOnboardingMobileLandscapeState extends UserOnboardingMobilePortraitState {}
