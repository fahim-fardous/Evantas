import 'package:domain/model/issue.dart';
import 'package:domain/model/issue_vote.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_argument.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_route.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_argument.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_route.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_argument.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:evntas/presentation/util/value_notifier_list.dart';

class IssueListViewModel extends BaseViewModel<IssueListArgument> {
  final AppRepository appRepository;
  final AuthRepository authRepository;
  final IssueRepository issueRepository;

  final ValueNotifierList<Issue> _issues = ValueNotifierList<Issue>([]);

  ValueNotifierList<Issue> get issues => _issues;

  final ValueNotifierList<Issue> _issueVotedByCurrentUser =
      ValueNotifierList<Issue>([]);

  ValueNotifierList<Issue> get issueVotedByCurrentUser =>
      _issueVotedByCurrentUser;

  IssueListViewModel(
    this.appRepository,
    this.authRepository,
    this.issueRepository,
  );

  @override
  void onViewReady({IssueListArgument? argument}) {
    super.onViewReady();
    _fetchIssues();
    _fetchIssueVotes();
  }

  Future<void> _fetchIssues() async {
    try {
      final userId = await appRepository.getUserId();

      if (userId == null) {
        showToast(
          uiText: FixedUiText(
            text: "Please login first",
          ),
        );
        return;
      }

      final issues = await loadData(issueRepository.getIssues(userId));
      _issues.value = issues;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _fetchIssueVotes() async {
    final userId = await appRepository.getUserId();
    if (userId == null) return;
    final issueVotes =
        await loadData(issueRepository.getIssueVotesByCurrentUser(userId));
    _issueVotedByCurrentUser.value = issueVotes;
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
    final userId = await appRepository.getUserId();
    navigateToScreen(
      destination: IssueDetailsRoute(
        arguments: IssueDetailsArgument(
          issueId: id,
          userId: userId ?? '',
        ),
      ),
      onPop: () => _fetchIssues(),
    );
  }

  Future<void> onLikeTap(int index) async {
    final userId = await appRepository.getUserId();
    if (userId == null) return;
    final issue = await issueRepository.fetchIssueById(index);
    if (issue == null) return;
    if (issue.isLiked != null && issue.isLiked == true) return;
    await loadData(issueRepository.likeIssue(issue, userId));
    _fetchIssues();
    _fetchIssueVotes();
  }

  Future<void> onDislikeTap(int index) async {
    final userId = await appRepository.getUserId();
    if (userId == null) return;
    final issue = await issueRepository.fetchIssueById(index);
    if (issue == null) return;
    if (issue.isDisliked != null && issue.isDisliked == true) return;
    await loadData(issueRepository.dislikeIssue(issue, userId));
    _fetchIssues();
    _fetchIssueVotes();
  }

  void onBackPressed() {
    navigateBack();
  }
}
