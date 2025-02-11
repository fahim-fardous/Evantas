import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/user_onboarding/binding/user_onboarding_binding.dart';
import 'package:evntas/presentation/feature/user_onboarding/route/user_onboarding_argument.dart';
import 'package:evntas/presentation/feature/user_onboarding/user_onboarding_view_model.dart';
import 'package:evntas/presentation/feature/user_onboarding/route/user_onboarding_route.dart';
import 'package:evntas/presentation/feature/user_onboarding/screen/user_onboarding_mobile_portrait.dart';
import 'package:evntas/presentation/feature/user_onboarding/screen/user_onboarding_mobile_landscape.dart';

class UserOnboardingAdaptiveUi extends BaseAdaptiveUi<UserOnboardingArgument, UserOnboardingRoute> {
  const UserOnboardingAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => UserOnboardingAdaptiveUiState();
}

class UserOnboardingAdaptiveUiState extends BaseAdaptiveUiState<UserOnboardingArgument, UserOnboardingRoute, UserOnboardingAdaptiveUi, UserOnboardingViewModel, UserOnboardingBinding> {
  @override
  UserOnboardingBinding binding = UserOnboardingBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return UserOnboardingMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return UserOnboardingMobileLandscape(viewModel: viewModel);
  }
}
