import 'package:domain/repository/auth_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/edit_profile/edit_profile_view_model.dart';

class EditProfileBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    AuthRepository authRepository = await diModule.resolve<AuthRepository>();
    return diModule.registerInstance(
      EditProfileViewModel(authRepository: authRepository),
    );
  }

  @override
  Future<void> removeDependencies() async {
    // return diModule.unregister<EditProfileViewModel>();
  }
}
