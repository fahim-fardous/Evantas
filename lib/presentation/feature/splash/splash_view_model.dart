import 'package:domain/model/app_info.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:evntas/presentation/feature/home/route/home_argument.dart';
import 'package:evntas/presentation/feature/home/route/home_route.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_argument.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_route.dart';
import 'package:evntas/presentation/feature/splash/route/splash_argument.dart';
import 'package:evntas/presentation/feature/user_onboarding/route/user_onboarding_argument.dart';
import 'package:evntas/presentation/feature/user_onboarding/route/user_onboarding_route.dart';

class SplashViewModel extends BaseViewModel<SplashArgument> {
  final AppRepository appRepository;
  final AuthRepository authRepository;

  SplashViewModel({
    required this.appRepository,
    required this.authRepository,
  });

  final ValueNotifier<AppInfo?> _appInfo = ValueNotifier(null);

  ValueListenable<AppInfo?> get appInfo => _appInfo;

  @override
  void onViewReady({SplashArgument? argument}) {
    super.onViewReady();
    _init();
  }

  void _init() async {
    await _fetchAppInfo();
    await _navigateToNextScreen();
  }

  Future<void> _fetchAppInfo() async {
    _appInfo.value = await loadData(appRepository.getAppInfo());
  }

  Future<void> _navigateToNextScreen() async {
    final isOnBoardingComplete = await appRepository.isOnBoardingComplete();
    final isUserLoggedIn = await authRepository.isLoggedIn();
    if (!isOnBoardingComplete) {
      navigateToScreen(
        destination: UserOnboardingRoute(
          arguments: UserOnboardingArgument(),
        ),
        isClearBackStack: true,
      );
      return;
    }

    if (!isUserLoggedIn) {
      navigateToScreen(
        destination: LoginRoute(
          arguments: LoginArgument(),
        ),
        isClearBackStack: true,
      );
      return;
    }

    navigateToScreen(
      destination: HomeRoute(
        arguments: HomeArgument(userId: '123'),
      ),
      isClearBackStack: true,
    );
  }
}
