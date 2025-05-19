import 'package:domain/model/issue.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_argument.dart';

class AddIssueViewModel extends BaseViewModel<AddIssueArgument> {
  final IssueRepository issueRepository;
  final AppRepository appRepository;

  AddIssueViewModel({
    required this.issueRepository,
    required this.appRepository,
  });

  @override
  void onViewReady({AddIssueArgument? argument}) {
    super.onViewReady();
  }

  bool isBlank(String title, String description) {
    if (title.isEmpty || description.isEmpty) {
      return true;
    }
    return false;
  }

  Future<void> onSavePressed(String title, String description) async {
    if (isBlank(title, description)) {
      showToast(uiText: FixedUiText(text: "Please fill up all fields"));
      return;
    }

    final userId = await appRepository.getUserId();

    if(userId == null){
      showToast(uiText: FixedUiText(text: "Please login first"));
      return;
    }

    await loadData(
      issueRepository.createIssue(
        issue: Issue(
          id: 0,
          title: title,
          description: description,
          createdBy: userId,
          createdAt: DateTime.now(),
        ),
      ),
    );

    navigateBack();
  }
}
