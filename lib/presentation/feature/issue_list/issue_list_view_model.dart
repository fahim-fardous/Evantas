import 'package:domain/model/issue.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_argument.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_route.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_argument.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_route.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_route.dart';
import 'package:evntas/presentation/util/value_notifier_list.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_argument.dart';

class IssueListViewModel extends BaseViewModel<IssueListArgument> {
  final AppRepository appRepository;
  final AuthRepository authRepository;
  final IssueRepository issueRepository;

  final ValueNotifierList<Issue> _issues = ValueNotifierList<Issue>([]);

  ValueNotifierList<Issue> get issues => _issues;

  IssueListViewModel(
    this.appRepository,
    this.authRepository,
    this.issueRepository,
  );

  @override
  void onViewReady({IssueListArgument? argument}) {
    super.onViewReady();
    _fetchIssues();
  }

  Future<void> _fetchIssues() async {
    try {
      final issues = await loadData(issueRepository.fetchIssues());
      _issues.value = issues;
    } catch (e) {
      rethrow;
    }
  }

  void onAddIssueButtonClicked() {
    navigateToScreen(
      destination: AddIssueRoute(
        arguments: AddIssueArgument(),
      ),
      onPop: () => _fetchIssues(),
    );
  }

  Future<void> onIssueClicked(int id) async {
    navigateToScreen(
      destination: IssueDetailsRoute(
        arguments: IssueDetailsArgument(issueId: id),
      ),
      onPop: () => _fetchIssues(),
    );
  }

  void onBackPressed() {
    navigateBack();
  }
}
