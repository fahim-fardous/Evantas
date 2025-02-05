import 'package:hello_flutter/presentation/base/base_binding.dart';
import 'package:hello_flutter/presentation/feature/user_onboarding/user_onboarding_view_model.dart';

class UserOnboardingBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // UserOnboardingRepository userOnboardingRepository = await diModule.resolve<UserOnboardingRepository>();
    return diModule.registerInstance(
      UserOnboardingViewModel(),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<UserOnboardingViewModel>();
  }
}
