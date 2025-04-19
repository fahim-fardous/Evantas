import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/home/screen/home_ui_mobile_potrait.dart';

class HomeUiMobileLandscape extends HomeUiMobilePortrait {
  const HomeUiMobileLandscape({required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => HomeUiMobileLandscapeState();
}

class HomeUiMobileLandscapeState extends HomeUiMobilePortraitState {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
