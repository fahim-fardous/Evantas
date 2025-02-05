import 'package:flutter/foundation.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/event_list/route/event_list_argument.dart';
import 'package:hello_flutter/presentation/feature/event_list/route/event_list_route.dart';
import 'package:hello_flutter/presentation/feature/home/route/home_argument.dart';
import 'package:hello_flutter/presentation/feature/home/route/home_route.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/route/user_onboarding_argument.dart';

class UserOnboardingViewModel extends BaseViewModel<UserOnboardingArgument> {
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  ValueNotifier<int> get currentPage => _currentPage;

  UserOnboardingViewModel();

  @override
  void onViewReady({UserOnboardingArgument? argument}) {
    super.onViewReady();
  }

  void onPageChanged(int index) {
    _currentPage.value = index;
  }

  void onSkipPressed() {
    navigateToScreen(
      destination: HomeRoute(
        arguments: HomeArgument(),
      ),
      isClearBackStack: true,
    );
  }

  void onGetStartedPressed() {
    navigateToScreen(
      destination: HomeRoute(
        arguments: HomeArgument(),
      ),
      isClearBackStack: true,
    );
  }
}
