import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/issue_details/issue_details_view_model.dart';

class IssueDetailsBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    IssueRepository issueRepository = await diModule.resolve<IssueRepository>();
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    AuthRepository authRepository = await diModule.resolve<AuthRepository>();
    return diModule.registerInstance(
      IssueDetailsViewModel(
        issueRepository: issueRepository,
        appRepository: appRepository,
        authRepository: authRepository,
      ),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<IssueDetailsViewModel>();
  }
}
