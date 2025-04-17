import 'package:domain/repository/auth_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/profile/profile_view_model.dart';

class ProfileBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    AuthRepository authRepository = await diModule.resolve<AuthRepository>();
    return diModule.registerInstance(
      ProfileViewModel(authRepository: authRepository),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<ProfileViewModel>();
  }
}
