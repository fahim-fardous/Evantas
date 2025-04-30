import 'package:domain/model/answer.dart';
import 'package:domain/model/issue.dart';
import 'package:domain/model/user_response_data.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:evntas/main/flavors.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:evntas/presentation/util/value_notifier_list.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_argument.dart';

class IssueDetailsViewModel extends BaseViewModel<IssueDetailsArgument> {
  final IssueRepository issueRepository;
  final AppRepository appRepository;
  final AuthRepository authRepository;

  final ValueNotifier<UserResponseData?> _userData = ValueNotifier(null);

  ValueNotifier<UserResponseData?> get userData => _userData;

  final ValueNotifier<Issue?> _issue = ValueNotifier(null);

  ValueNotifier<Issue?> get issue => _issue;

  final ValueNotifierList<Answer> _answers = ValueNotifierList<Answer>([]);

  ValueNotifierList<Answer?> get answers => _answers;

  IssueDetailsViewModel({
    required this.issueRepository,
    required this.appRepository,
    required this.authRepository,
  });

  @override
  void onViewReady({IssueDetailsArgument? argument}) {
    super.onViewReady();
    _fetchUserInfo();
    _fetchIssue(argument?.issueId);
    _fetchAnswers(argument?.issueId);
  }

  Future<void> _fetchUserInfo() async {
    final userId = await appRepository.getUserId();

    if (userId == null) return;
    final user = await loadData(authRepository.getUserById(userId));

    if (user == null) return;
    _userData.value = user;
  }

  Future<void> _fetchIssue(int? issueId) async {
    if (issueId == null) return;
    final issue = await loadData(issueRepository.fetchIssueById(issueId));
    if (issue == null) return;
    _issue.value = issue;
  }

  Future<void> _fetchAnswers(int? issueId) async {
    if (issueId == null) return;
    final answers =
        await loadData(issueRepository.getAnswersByIssueId(issueId));

    if (answers.isNotEmpty) {
      _answers.value = answers;
    }
  }

  Future<void> saveAnswer(String answer, int issueId) async {
    if (answer.isEmpty) {
      showToast(uiText: FixedUiText(text: "Please fill up all fields"));
      return;
    }

    final userId = await appRepository.getUserId();

    if (userId == null) {
      showToast(uiText: FixedUiText(text: "Please login first"));
      return;
    }

    await loadData(
      issueRepository.saveAnswer(
        answer: Answer(
          id: 0,
          answer: answer,
          answeredBy: userId,
          answeredAt: DateTime.now(),
          votes: 0,
          isAnswerAccepted: false,
          issueId: issueId,
        ),
      ),
    );

    _fetchAnswers(issueId);
  }

  void onBackPressed() {
    navigateBack();
  }
}
