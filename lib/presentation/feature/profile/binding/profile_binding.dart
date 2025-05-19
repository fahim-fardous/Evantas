import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:domain/repository/profile_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/profile/profile_view_model.dart';

class ProfileBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    AuthRepository authRepository = await diModule.resolve<AuthRepository>();
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    ProfileRepository profileRepository = await diModule.resolve<ProfileRepository>();
    IssueRepository issueRepository = await diModule.resolve<IssueRepository>();

    return diModule.registerInstance(
      ProfileViewModel(
        authRepository: authRepository,
        appRepository: appRepository,
        profileRepository: profileRepository,
        issueRepository: issueRepository,
      ),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<ProfileViewModel>();
  }
}
