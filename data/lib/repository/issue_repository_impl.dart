import 'package:data/mapper/answer_mapper.dart';
import 'package:data/mapper/comment_mapper.dart';
import 'package:data/mapper/issue_mapper.dart';
import 'package:data/service/supabase_service.dart';
import 'package:domain/model/answer.dart';
import 'package:domain/model/comment.dart';
import 'package:domain/model/issue.dart';
import 'package:domain/model/issue_vote.dart';
import 'package:domain/repository/issue_repository.dart';

class IssueRepositoryImpl extends IssueRepository {
  final SupabaseService supabaseService;

  IssueRepositoryImpl({required this.supabaseService});

  @override
  Future<void> createIssue({required Issue issue}) async {
    try {
      await supabaseService.addIssue(issue);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Issue>> getIssues(String userId) async {
    try {
      final issues = await supabaseService.getIssues(userId);
      return issues
          .map((issue) => IssueMapper.mapResponseToDomain(issue))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Issue?> fetchIssueById(int issueId) async {
    try {
      final issue = await supabaseService.getIssueById(issueId);
      if (issue == null) return null;
      return IssueMapper.mapResponseToDomain(issue);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Answer>> getAnswersByIssueId(int issueId) async {
    try {
      final answers = await supabaseService.getAnswersByIssueId(issueId);
      if (answers == null) return [];
      return answers
          .map((answer) => AnswerMapper.mapResponseToDomain(answer))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Answer>> getAllAnswers() {
    // TODO: implement getAllAnswers
    throw UnimplementedError();
  }

  @override
  Future<void> saveAnswer({required Answer answer}) async {
    try {
      await supabaseService.addAnswer(answer);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> likeIssue(Issue issue, String userId) async {
    try {
      return supabaseService.likeIssue(issue, userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> dislikeIssue(Issue issue, String userId) async {
    try {
      await supabaseService.dislikeIssue(issue,userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Issue>> getIssueVotesByCurrentUser(String userId) async{
    try{
      final issueVotes = await supabaseService.getIssueVotesByCurrentUser(userId);
      return issueVotes.map((issueVote) => IssueMapper.mapResponseToDomain(issueVote)).toList();
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<Issue?> getIssueVoteById(int issueId, String userId) async{
    try{
      final issueVote = await supabaseService.getIssueVoteById(issueId, userId);
      if(issueVote == null) return null;
      return IssueMapper.mapResponseToDomain(issueVote);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void > addComment(Comment comment) async{
    try{
      await supabaseService.addComment(comment);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<Comment>> fetchCommentsByIssueId(int id) async{
    try{
      final comments = await supabaseService.getCommentsByIssueId(id);
      if(comments.isEmpty) return [];
      return comments.map((comment) => CommentMapper.mapResponseToDomain(comment)).toList();
    }catch(e){
      rethrow;
    }
  }
}
