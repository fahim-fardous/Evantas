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

  final ValueNotifier<bool> _isCreatorLoading = ValueNotifier(false);

  ValueNotifier<bool> get isCreatorLoading => _isCreatorLoading;

  final ValueNotifier<Issue?> _issue = ValueNotifier(null);

  ValueNotifier<Issue?> get issue => _issue;

  final ValueNotifier<Issue?> _issueVote = ValueNotifier(null);

  ValueNotifier<Issue?> get issueVote => _issueVote;

  final ValueNotifierList<Comment> _comments = ValueNotifierList<Comment>([]);

  ValueNotifierList<Comment> get comments => _comments;

  final ValueNotifierList<UserResponseData> _users =
      ValueNotifierList<UserResponseData>([]);

  ValueNotifierList<UserResponseData> get users => _users;

  int? _activeIssueId;
  int _requestToken = 0;

  IssueDetailsViewModel({
    required this.issueRepository,
    required this.appRepository,
    required this.authRepository,
  });

  @override
  void onViewReady({IssueDetailsArgument? argument}) {
    super.onViewReady();
    _activeIssueId = argument?.issueId;
    _requestToken++;
    final token = _requestToken;

    _resetDetailState();

    if (_activeIssueId == null) return;
    _isCreatorLoading.value = true;

    _fetchUserInfo(_activeIssueId!, token);
    _fetchIssue(_activeIssueId!, token);
    _fetchAnswers(_activeIssueId!, token);
  }

  void _resetDetailState() {
    _isCreatorLoading.value = false;
    _userData.value = null;
    _issue.value = null;
    _users.value = [];
    _comments.value = [];
  }

  bool _isActiveRequest(int issueId, int token) {
    return _activeIssueId == issueId && _requestToken == token;
  }

  Future<void> _fetchUserInfo(int issueId, int token) async {
    final issue = await loadData(issueRepository.fetchIssueById(issueId));
    if (issue == null || !_isActiveRequest(issueId, token)) {
      if (_isActiveRequest(issueId, token)) {
        _isCreatorLoading.value = false;
      }
      return;
    }

    final user = await loadData(authRepository.getUserById(issue.createdBy));
    if (!_isActiveRequest(issueId, token)) return;
    if (user != null) {
      _userData.value = user;
      _isCreatorLoading.value = false;
      return;
    }

    // Fallback when creator exists in auth provider but not in users table.
    final googleUser = await loadData(authRepository.getUserData());
    if (!_isActiveRequest(issueId, token)) return;
    if (googleUser.id == issue.createdBy) {
      _userData.value = UserResponseData(
        id: 0,
        name: googleUser.name,
        email: googleUser.email,
        photoUrl: googleUser.photoUrl,
        fcmToken: '',
        role: '',
        userId: googleUser.id,
      );
    }
    _isCreatorLoading.value = false;
  }

  Future<void> _fetchIssue(int issueId, int token) async {
    final issue = await loadData(issueRepository.fetchIssueById(issueId));
    if (issue == null || !_isActiveRequest(issueId, token)) return;
    _issue.value = issue;
  }

  Future<void> _fetchAnswers(int issueId, int token) async {
    final comments =
        await loadData(issueRepository.fetchCommentsByIssueId(issueId));
    if (!_isActiveRequest(issueId, token)) return;
    if (comments.isEmpty) {
      _users.value = [];
      _comments.value = [];
      return;
    }

    List<UserResponseData> users = [];
    List<Comment> validComments = [];

    for (final comment in comments) {
      final user =
          await authRepository.getUserById(comment.commentedBy);
      if (!_isActiveRequest(issueId, token)) return;
      if (user != null) {
        users.add(user);
        validComments.add(comment);
      }
    }
    _users.value = users;

    _comments.value = validComments;
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

    _fetchAnswers(issueId, _requestToken);
  }

  void onBackPressed() {
    navigateBack();
  }
}
