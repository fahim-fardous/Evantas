import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/issue_list/issue_list_view_model.dart';

class IssueListBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    AuthRepository authRepository = await diModule.resolve<AuthRepository>();
    IssueRepository issueRepository = await diModule.resolve<IssueRepository>();
    return diModule.registerInstance(
      IssueListViewModel(
        appRepository,
        authRepository,
        issueRepository,
      ),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<IssueListViewModel>();
  }
}
