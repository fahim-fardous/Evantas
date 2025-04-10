import 'package:data/local/shared_preference/shared_pref_manager.dart';
import 'package:domain/model/app_info.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/auth/login/route/login_argument.dart';
import 'package:hello_flutter/presentation/feature/auth/login/route/login_route.dart';
import 'package:hello_flutter/presentation/feature/splash/route/splash_argument.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/route/user_onboarding_argument.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/route/user_onboarding_route.dart';

class SplashViewModel extends BaseViewModel<SplashArgument> {
  final AppRepository appRepository;

  SplashViewModel({required this.appRepository});

  final ValueNotifier<AppInfo?> _appInfo = ValueNotifier(null);

  ValueListenable<AppInfo?> get appInfo => _appInfo;

  @override
  void onViewReady({SplashArgument? argument}) {
    super.onViewReady();
    _fetchAppInfo();
    _navigateToNextScreen();
  }

  Future<void> _fetchAppInfo() async {
    _appInfo.value = await loadData(appRepository.getAppInfo());
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final isFirstLaunched = await appRepository.isOnboarded();
    if(isFirstLaunched == false) {
      navigateToScreen(
        destination: UserOnboardingRoute(
          arguments: UserOnboardingArgument(),
        ),
        isClearBackStack: true,
      );
      return;
    }
    navigateToScreen(
      destination: LoginRoute(
        arguments: LoginArgument(),
      ),
      isClearBackStack: true,
    );
  }
}
