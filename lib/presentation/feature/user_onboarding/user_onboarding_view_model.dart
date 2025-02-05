import 'package:flutter/foundation.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/route/user_onboarding_argument.dart';

class UserOnboardingViewModel extends BaseViewModel<UserOnboardingArgument> {

  final ValueNotifier<String> _message = ValueNotifier('UserOnboarding');

  ValueListenable<String> get message => _message;

  int count = 0;

  UserOnboardingViewModel();

  @override
  void onViewReady({UserOnboardingArgument? argument}) {
    super.onViewReady();
  }

  void onClick() {
     count++;
    _message.value = '${message.value}$count';
  }

}
