import 'package:domain/repository/app_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/user_onboarding/user_onboarding_view_model.dart';

class UserOnboardingBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    return diModule.registerInstance(
      UserOnboardingViewModel(appRepository: appRepository),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<UserOnboardingViewModel>();
  }
}
