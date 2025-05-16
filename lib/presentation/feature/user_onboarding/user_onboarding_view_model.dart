import 'package:data/local/shared_preference/shared_pref_manager.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/event_list/route/event_list_argument.dart';
import 'package:evntas/presentation/feature/event_list/route/event_list_route.dart';
import 'package:evntas/presentation/feature/home/route/home_argument.dart';
import 'package:evntas/presentation/feature/home/route/home_route.dart';
import 'package:evntas/presentation/feature/user_onboarding/route/user_onboarding_argument.dart';

class UserOnboardingViewModel extends BaseViewModel<UserOnboardingArgument> {
  final AppRepository appRepository;
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  ValueNotifier<int> get currentPage => _currentPage;

  UserOnboardingViewModel({
    required this.appRepository,
  });

  @override
  void onViewReady({UserOnboardingArgument? argument}) {
    super.onViewReady();
  }

  void onPageChanged(int index) {
    _currentPage.value = index;
  }

  Future<void> onSkipPressed() async {
    await appRepository.setOnBoardingComplete(true);
    navigateToScreen(
      destination: HomeRoute(
        arguments: HomeArgument(),
      ),
      isClearBackStack: true,
    );
  }

  Future<void> onGetStartedPressed() async {
    await appRepository.setOnBoardingComplete(true);
    navigateToScreen(
      destination: HomeRoute(
        arguments: HomeArgument(),
      ),
      isClearBackStack: true,
    );
  }
}
