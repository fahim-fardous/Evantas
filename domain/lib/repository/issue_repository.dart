import 'package:domain/model/answer.dart';
import 'package:domain/model/issue.dart';

abstract class IssueRepository {
  Future<void> createIssue({
    required Issue issue,
  });

  Future<List<Issue>> fetchIssues();

  Future<Issue?> fetchIssueById(int issueId);

  Future<List<Answer>> getAnswersByIssueId(int issueId);

  Future<void> saveAnswer({required Answer answer});

  Future<List<Answer>> getAllAnswers();
}
