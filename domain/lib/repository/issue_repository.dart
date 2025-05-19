import 'package:domain/model/answer.dart';
import 'package:domain/model/comment.dart';
import 'package:domain/model/issue.dart';
import 'package:domain/model/issue_vote.dart';

abstract class IssueRepository {
  Future<void> createIssue({
    required Issue issue,
  });

  Future<List<Issue>> getIssues(String userId);

  Future<Issue?> fetchIssueById(int issueId);

  Future<List<Answer>> getAnswersByIssueId(int issueId);

  Future<void> saveAnswer({required Answer answer});

  Future<List<Answer>> getAllAnswers();

  Future<void> likeIssue(Issue issue, String userId);

  Future<void> dislikeIssue(Issue issue, String userId);

  Future<List<Issue>> getIssueVotesByCurrentUser(String userId);

  Future<Issue?> getIssueVoteById(int issueId, String userId);

  Future<void> addComment(Comment comment);

  Future<List<Comment>> fetchCommentsByIssueId(int id);
}
