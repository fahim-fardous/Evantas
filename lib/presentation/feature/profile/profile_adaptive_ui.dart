import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/profile/binding/profile_binding.dart';
import 'package:evntas/presentation/feature/profile/route/profile_argument.dart';
import 'package:evntas/presentation/feature/profile/profile_view_model.dart';
import 'package:evntas/presentation/feature/profile/route/profile_route.dart';
import 'package:evntas/presentation/feature/profile/screen/profile_mobile_portrait.dart';
import 'package:evntas/presentation/feature/profile/screen/profile_mobile_landscape.dart';

class ProfileAdaptiveUi extends BaseAdaptiveUi<ProfileArgument, ProfileRoute> {
  const ProfileAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => ProfileAdaptiveUiState();
}

class ProfileAdaptiveUiState extends BaseAdaptiveUiState<ProfileArgument, ProfileRoute, ProfileAdaptiveUi, ProfileViewModel, ProfileBinding> {
  @override
  ProfileBinding binding = ProfileBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return ProfileMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return ProfileMobileLandscape(viewModel: viewModel);
  }
}
