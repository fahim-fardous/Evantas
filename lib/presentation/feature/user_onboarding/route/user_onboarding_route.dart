import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_route.dart';
import 'package:hello_flutter/presentation/navigation/route_path.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/user_onboarding_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/route/user_onboarding_argument.dart';

class UserOnboardingRoute extends BaseRoute<UserOnboardingArgument> {
  @override
  RoutePath routePath = RoutePath.userOnboarding;

  UserOnboardingRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => UserOnboardingAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
