import 'package:domain/model/answer.dart';
import 'package:domain/model/comment.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';

class IssueDetailsViewModel extends BaseViewModel<IssueDetailsArgument> {
  final IssueRepository issueRepository;
  final AppRepository appRepository;
  final AuthRepository authRepository;

  final ValueNotifier<UserResponseData?> _userData = ValueNotifier(null);

  ValueNotifier<UserResponseData?> get userData => _userData;

  final ValueNotifier<Issue?> _issue = ValueNotifier(null);

  ValueNotifier<Issue?> get issue => _issue;

  final ValueNotifier<Issue?> _issueVote = ValueNotifier(null);

  ValueNotifier<Issue?> get issueVote => _issueVote;

  final ValueNotifierList<Comment> _comments = ValueNotifierList<Comment>([]);

  ValueNotifierList<Comment> get comments => _comments;

  final ValueNotifierList<UserResponseData> _users =
      ValueNotifierList<UserResponseData>([]);

  ValueNotifierList<UserResponseData> get users => _users;

  IssueDetailsViewModel({
    required this.issueRepository,
    required this.appRepository,
    required this.authRepository,
  });

  @override
  void onViewReady({IssueDetailsArgument? argument}) {
    super.onViewReady();
    _fetchUserInfo(argument?.issueId);
    _fetchIssue(argument?.issueId);
    _fetchAnswers(argument?.issueId);
  }

  Future<void> _fetchUserInfo(int? issueId) async {
    if (issueId == null) return;
    final issue = await loadData(issueRepository.fetchIssueById(issueId));

    final user =
        await loadData(authRepository.getUserById(issue?.createdBy ?? ''));

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

    final comments =
        await loadData(issueRepository.fetchCommentsByIssueId(issueId));
    if (comments.isEmpty) return;

    List<UserResponseData> users = [];

    for (final comment in comments) {
      final user =
          await authRepository.getUserById(comment.commentedBy);
      if (user != null) {
        users.add(user);
      }
    }
    _users.value = users;

    _comments.value = comments;
  }

  Future<void> saveComment(String comment, int issueId) async {
    if (comment.isEmpty) {
      showToast(uiText: FixedUiText(text: "Please fill up all fields"));
      return;
    }

    final userId = await appRepository.getUserId();

    if (userId == null) {
      showToast(uiText: FixedUiText(text: "Please login first"));
      return;
    }

    await loadData(
      issueRepository.addComment(
        Comment(
          id: 0,
          comment: comment,
          commentedBy: userId,
          commentedAt: DateTime.now(),
          isAccepted: false,
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
