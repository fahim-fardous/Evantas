import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/add_issue/add_issue_view_model.dart';

class AddIssueBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    IssueRepository issueRepository = await diModule.resolve<IssueRepository>();
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    return diModule.registerInstance(
      AddIssueViewModel(
        issueRepository: issueRepository,
        appRepository: appRepository,
      ),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<AddIssueViewModel>();
  }
}
