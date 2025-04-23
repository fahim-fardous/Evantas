import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/profile_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/edit_profile/edit_profile_view_model.dart';

class EditProfileBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    AuthRepository authRepository = await diModule.resolve<AuthRepository>();
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    ProfileRepository profileRepository =
        await diModule.resolve<ProfileRepository>();
    return diModule.registerInstance(
      EditProfileViewModel(
        authRepository: authRepository,
        appRepository: appRepository,
        profileRepository: profileRepository,
      ),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<EditProfileViewModel>();
  }
}
