import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/screen/sign_up_mobile_portrait.dart';

class SignUpMobileLandscape extends SignUpMobilePortrait {
  const SignUpMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => SignUpMobileLandscapeState();
}

class SignUpMobileLandscapeState extends SignUpMobilePortraitState {}
